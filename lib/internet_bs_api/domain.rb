require "#{Rails.root}/lib/internet_bs_api/connection.rb"
require "#{Rails.root}/lib/internet_bs_api/exception.rb"
require "#{Rails.root}/lib/internet_bs_api/utilities.rb"

module InternetBsApi
  module Domain

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/01_domain_check
    def check_domain(domain_name_with_tld)
      # validation
      if check_domain_format(clone_contact_domain) == false
        raise InvalidInputParameters.new("Invalid domain format. Please use this format: example.net")
      end

      connection = Connection.new
      options = {"Domain" => domain_name_with_tld}
      connection.post("Domain/Check", options)
    end

    # --------------------------------------------------------------------------------------------

    # convenience method:  this will check a domain against a list of tlds that
    # are of interest. Still calls the one at a time check above for each tld
    def check_multiple_tlds(domain, tlds)
      # TODO: representation for response that is more useful.
      responses = []
      tlds.each do |tld|
        domain_name_with_tld = domain + "." + tld
        responses << check_availability(domain_name_with_tld)
      end
      responses
    end

    # --------------------------------------------------------------------------------------------

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/02_domain_create
    def create_domain(domain_name_with_tld, contacts, clone_contact_domain)
      # validation
      if contacts.nil? && check_domain_format(clone_contact_domain) == false
        raise InvalidInputParameters.new("You must provide either valid contacts or a valid contact clone domain parameter")
      end

      connection = Connection.new
      options = {}
      if contacts
        options = contacts
      else
        options["CloneContactsFromDomain"] = clone_contact_domain
      end
      options["Domain"] = domain_name_with_tld

      # this is create, so there is no member component to the URL
      connection.post("Domain/Create", options)
    end

    # --------------------------------------------------------------------------------------------

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/03_domain_update
    def update_domain(domain_name_with_tld, contacts, clone_contact_domain)
      # validation
      if check_domain_format(domain_name_with_tld) == false
        raise InvalidInputParameters.new("Invalid domain format. Please use this format: example.net")
      end
      if clone_contact_domain && check_domain_format(clone_contact_domain) == false
        raise InvalidInputParameters.new("Invalid clone contact domain format. Please use this format: example.net")
      end

      connection = Connection.new
      options = {}
      if contacts
        options = contacts
      elsif clone_contact_domain
        options["CloneContactsFromDomain"] = clone_contact_domain
      end
      options["Domain"] = domain_name_with_tld

      connection.post("Domain/Update", options)
    end

    # --------------------------------------------------------------------------------------------

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/04_domain_renew
    def renew_domain(domain_name_with_tld, period_optional, discount_code_optional)
      if check_domain_format(domain_name_with_tld) == false
        raise InvalidInputParameters.new("Invalid domain format. Please use this format: example.net")
      end

      connection = Connection.new
      options = {}
      options["Period"] = period_optional if period_optional
      options["DiscountCode"] = discount_code_optional if discount_code_optional
      options["Domain"] = domain_name_with_tld

      connection.post("Domain/Renew", options)
    end

    # --------------------------------------------------------------------------------------------

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/05_domain_info
    def get_domain(domain_name_with_tld)
      if check_domain_format(domain_name_with_tld) == false
        raise InvalidInputParameters.new("Invalid domain format. Please use this format: example.net")
      end

      options = {"Domain" => domain_name_with_tld}
      connection.post("Domain/Info", options)
    end

    # --------------------------------------------------------------------------------------------

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/06_domain_list
    def list_domains(expiring_only_optional,
                     pending_transfer_only_optional,
                     range_from_optional,
                     range_to_optional,
                     search_term_filter_optional,
                     compact_list_optional,
                     sort_by_optional,
                     extension_filter_optional)

      connection = Connection.new
      options = {}
      options["ExpiringOnly"] = expiring_only_optional if expiring_only_optional
      options["PendingTransferOnly"] = pending_transfer_only_optional if pending_transfer_only_optional
      options["RangeFrom"] = range_from_optional if range_from_optional
      options["RangeTo"] = range_to_optional if range_to_optional
      options["SearchTermFilter"] = search_term_filter_optional  if search_term_filter_optional
      options["CompactList"] = compact_list_optional if compact_list_optional
      options["SortBy"] = sort_by_optional if sort_by_optional
      options["ExtensionFilter"] = extension_filter_optional if extension_filter_optional

      connection.post("Domain/List", options)
    end

    # --------------------------------------------------------------------------------------------

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/07_domain_registry_status
    def registry_status(domain_name_with_tld)
      if check_domain_format(domain_name_with_tld) == false
        raise InvalidInputParameters.new("Invalid domain format. Please use this format: example.net")
      end

      options = {"Domain" => domain_name_with_tld}
      connection = Connection.new
      connection.post("Domain/RegistryStatus", options)
    end

    # --------------------------------------------------------------------------------------------

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/08_domain_push
    def push_domain(domain_name_with_tld, destination)
      if destination.nil? && check_domain_format(domain_name_with_tld) == false
        raise InvalidInputParameters.new("Destination is a required parameter") if destination.nil?
        raise InvalidInputParameters.new("Invalid domain format. Please use this format: example.net")
      end

      options = {"Domain" => domain_name_with_tld, "Destination" => destination}
      connection = Connection.new
      connection.post("Domain/Push", options)
    end

    # --------------------------------------------------------------------------------------------

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/09_domain_count
    def count_domains
      options = {}
      connection = Connection.new
      connection.post("Domain/Count", options)
    end
  end
end
