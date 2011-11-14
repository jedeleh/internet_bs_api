require "#{Rails.root}/lib/internet_bs_api/connection.rb"

module InternetBsApi
  module Domain
    def check_domain(domain_name_with_tld)
      connection = Connection.new
      options = {"Domain" => domain_name_with_tld}
      connection.post("Domain/Check", options)
    end

    def check_multiple_tlds(domain, tlds)
      # TODO: representation for response that is more useful.
      responses = []
      tlds.each do |tld|
        domain_name_with_tld = domain + "." + tld
        responses << check_availability(domain_name_with_tld)
      end
      responses
    end

    def create_domain(domain_name_with_tld, contacts)
      connection = Connection.new
      options = {}
      if admin_contact
        options = admin_contact.internet_bs_format nil
      end
      options["Domain"] = domain_name_with_tld

      # this is create, so there is no member component to the URL
      connection.post("Domain/Create", options)
    end

    def update_domain
      puts "update domain"
    end

    def renew_domain
    end

    def get_domain(domain)
      options = {"Domain" => domain}
      connection.post("Domain/Info", options)
    end

    def list_domains
    end

    def registry_status
    end

    def count_domain
    end
  end
end
