require "#{Rails.root}/lib/internet_bs_api/connection.rb"
require "#{Rails.root}/lib/internet_bs_api/exceptions.rb"
require "#{Rails.root}/lib/internet_bs_api/utilities.rb"

module InternetBsApi
  module Domain

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/01_domain_check
    #
    # /Domain/Check
    #
    # The command is intended to check whether a domain is available for
    # registration or not. The command is not generating any cost.
    #
    # Required data:
    #  transactid=e504cdbf00e7821e954f0f5a65249ff0
    #  status=UNAVAILABLE
    #  domain=example.com
    #  minregperiod=1Y
    #  maxregperiod=10Y
    #  registrarlockallowed=YES
    #  privatewhoisallowed=YES
    #  realtimeregistration=YES
    #
    # Example return data:
    #  transactid=e870cdbf00e7821e954f0f5a62349ff0
    #  status=UNAVAILABLE
    #  domain=тираспол.com
    #  punycode=xn--80apkleeie.com
    #  minregperiod=1Y
    #  maxregperiod=10Y
    #  registrarlockallowed=YES
    #  privatewhoisallowed=YES
    #  realtimeregistration=YES
    #
    def check_domain(domain_name_with_tld)
      # validation
      validate_list([ ["Domain", domain_name_with_tld, :domain_format] ])

      connection = Connection.new
      options = {"Domain" => domain_name_with_tld}
      connection.post("Domain/Check", options)
    end

    # convenience method:  this will check a domain against a list of tlds that
    # are of interest. Still calls the one at a time check above for each tld
    def check_multiple_tlds(domain, tlds)
      responses = []
      tlds.each do |tld|
        domain_name_with_tld = domain + "." + tld
        responses << check_availability(domain_name_with_tld)
      end
      responses
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/02_domain_create
    #
    # /Domain/Create
    #
    # The command is intended to register a new domain; while there are dozens
    # of optional parameters, only a few are required, other parameters can be
    # safely ignored and used only if and when you really need them
    #
    # Returned data:
    #  STATUS=SUCCESS or PENDING or FAILURE
    #  TRANSACTID=Transaction ID reference
    #  Domain=domain name
    #  DomainExpiration=Date
    #  privateWhois=DISABLED or FULL or PARTIAL
    #
    # Example return data:
    #  transactid=820b6791e386b31b354e613a6371c7bc
    #  currency=USD
    #  price=13.9
    #  product_0_privatewhois=partial
    #  product_0_price=13.9
    #  product_0_status=SUCCESS
    #  product_0_domain=example.com
    #  product_0_expiration=2010/04/02
    #
    def create_domain(domain_name_with_tld, contacts_optional, clone_contact_domain_optional)
      # validation
      validate_list([ ["Domain", domain_name_with_tld, :domain_format] ])
      if contacts_optional.nil? && check_domain_format(clone_contact_domain_optional) == false
        raise InvalidInputParameters.new("You must provide either valid contacts or a valid contact clone domain parameter")
      end

      connection = Connection.new
      options = {}
      if contacts_optional
        contacts_optional.each do |co|
          options.merge!(co.to_options)
        end
      else
        options["CloneContactsFromDomain"] = clone_contact_domain_optional
      end
      options["Domain"] = domain_name_with_tld

      # this is create, so there is no member component to the URL
      connection.post("Domain/Create", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/03_domain_update
    #
    # /Domain/Update
    #
    # The command is intended to update a domain, including Registrant Contact,
    # Billing Contact, Admin Contact, Tech. Contact, registrar locks status,
    # epp auth info, name servers, private whois status, etc...
    #
    # The command takes exactly the same parameters as /Domain/Create, however
    # only Domain is mandatory, all other parameters are optional and you can
    # update one or more of them at once.
    #
    # Returned data:
    #  STATUS=SUCCESS or PENDING or FAILURE
    #  TrasactID: Transaction ID reference
    #  Domain=domain name
    #
    # Example return data:
    #  transactid=65a247a02837d3334196915143ea613e
    #  status=SUCCESS
    #
    def update_domain(domain_name_with_tld, contacts_optional, clone_contact_domai_optionaln)
      # validation
      validate_list([ ["Domain", domain_name_with_tld, :domain_format] ])
      if contacts_optional.nil? && check_domain_format(clone_contact_domain_optional) == false
        raise InvalidInputParameters.new("You must provide either valid contacts or a valid contact clone domain parameter")
      end

      connection = Connection.new
      options = {}
      if contacts_optional
        contacts_optional.each do |co|
          options.merge!(co.to_options)
        end
      elsif clone_contact_domain
        options["CloneContactsFromDomain"] = clone_contact_domai_optional
      end
      options["Domain"] = domain_name_with_tld

      connection.post("Domain/Update", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/04_domain_renew
    #
    # /Domain/Renew
    #
    # The command is intended to renew a domain.
    #
    # Returned data:
    #
    #  STATUS=SUCCESS or PENDING or FAILURE
    #  TRANSACTID= Transaction ID
    #  Domain=Domain name
    #  newExpiration=date
    #
    # Example return data:
    #  transactid=4e74069f2b5d1d62282c21d0a2e49a27
    #  currency=USD
    #  price=6.5
    #  product_0_price=6.5
    #  product_0_status=SUCCESS
    #  product_0_domain=test-api-domain7.net
    #  product_0_newexpiration=2012/03/05
    #
    def renew_domain(domain_name_with_tld, period_optional, discount_code_optional)
      validate_list([ ["Domain", domain_name_with_tld, :domain_format] ])

      connection = Connection.new
      options = {}
      options["Period"] = period_optional if period_optional
      options["DiscountCode"] = discount_code_optional if discount_code_optional
      options["Domain"] = domain_name_with_tld

      connection.post("Domain/Renew", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/05_domain_info
    #
    # /Domain/Info
    #
    # The command is intended to return full details about a domain name; it
    # includes contact details, registrar lock status, private whois status,
    # name servers and so on. All the parameters you have set for a domain
    # using either /Domain/Create and/or /Domain/Update will be returned after
    # execution with the corresponding value.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #  Domain=domain name
    #  DomainExpiration=Date
    #  transferAuthInfo=epp auth code or equivalent if admitted or empty
    #  registrarLock=ENABLED or DISABLED or NOTADMITTED
    #  privateWhois=DISABLED or FULL or PARTIAL
    #  autorenew=YES if autorenew for a given domain set or NO if not
    #  domainstatus=current domain status REGISTRED, REGISTRAR LOCKED, PENDING TRANSFER, PENDING TRADE, ON HOLD, EXPIRED, UNKNOWN
    #  Registrant_Firstname=
    #  Registrant_Lastname=
    #  Punycode = in case the domain is an IDN (International Domain Name) its
    #  punycode representation will be in this field. Otherwise this field is
    #  not present in the response.
    #
    # Example return data:
    #  transactid=1542c06388d8e03e14613788ca6bd914
    #  status=SUCCESS
    #  domain=test-api-domain11.com
    #  expirationdate=2011/03/05
    #  registrarlock=ENABLED
    #  privatewhois=DISABLED
    #  autorenew=YES
    #  domainstatus=REGISTERED
    #  contacts_registrant_firstname=Test
    #  contacts_registrant_lastname=Api
    #  contacts_registrant_email=abc@test.com
    #  contacts_registrant_phonenumber=+33.146361234
    #  contacts_registrant_organization=
    #  contacts_registrant_city=Bahamas
    #  contacts_registrant_street=Bahamas
    #  contacts_registrant_street2=
    #  contacts_registrant_stree3=
    #  contacts_registrant_postalcode=123456
    #  contacts_registrant_countrycode=BS
    #  contacts_registrant_country=BAHAMAS
    #  contacts_technical_firstname=Test
    #  ...
    #  contacts_technical_country=BAHAMAS
    #  contacts_admin_firstname=Test
    #  ...
    #  contacts_admin_country=BAHAMAS
    #  contacts_billing_firstname=Test
    #  ...
    #  contacts_billing_country=BAHAMAS
    #  transferauthinfo=testauthinfo
    def get_domain(domain_name_with_tld)
      validate_list([ ["Domain", domain_name_with_tld, :domain_format] ])

      options = {"Domain" => domain_name_with_tld}
      connection.post("Domain/Info", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/06_domain_list
    #
    # /Domain/List
    #
    # This command is intended to retrieve a list of domains in your account.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #  DomainCount=XXXX
    #  DomainN=domainname.ext or domainname.ext:EXPIRATION:REGISTRARLOCK:EPPAUTHCODE
    #
    # Example returned data with CompactList=yes:
    #  transactid = 74e5a6a2e6ef0b6c199244232c095074
    #  status = SUCCESS
    #  domaincount = 59
    #  domain_0 = test-api-domain1.eu
    #  domain_1 = test-api-domain1.net
    #  domain_2 = test-api-domain10.com
    #  domain_3 = привет-россия.com
    #
    # Example returned data with CompactList=no:
    #  transactid=260b4252a4a373182fadc01abddcb074
    #  status=SUCCESS
    #  domaincount=47
    #  domain_0_name=aaaaaaaaaawwwwwwwwwwwrrrr-2.com
    #  domain_0_expiration=n/a
    #  domain_0_status=ok
    #  domain_0_registrarlock=enabled
    #  domain_0_transferauthinfo=bOVHFfN1gXRh
    #  domain_1_name=domain1.com
    #  domain_1_expiration=2011/01/28
    #  domain_1_status=ok
    #  domain_1_registrarlock=disabled
    #  domain_1_transferauthinfo=DNANFiuBNAXH
    #  domain_2_name=abc.com
    #  domain_2_expiration=n/a
    #  domain_2_status=Pending transfer
    #  domain_2_registrarlock=disabled
    #  domain_2_transferauthinfo=
    #  domain_3_name= привет-россия.com
    #  domain_3_expiration=2011/01/28
    #  domain_3_status=ok
    #  domain_3_registrarlock=disabled
    #  domain_3_transferauthinfo=2SFSD4233
    #  domain_3_punycode = xn----ctbjkd9acielah9o.com
    #
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

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/07_domain_registry_status
    #
    # /Domain/RegistryStatus
    #
    # The command is intended to view a domain registry status.
    #
    # Returned data:
    #
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #  Domain=Domain name
    #  RegistryStatus=The domain status at the registry. This field may appear multiple times
    #
    # Example return data:
    #  transactid=bf36790902ee8f1c32aaf64f82be74c3
    #  status=SUCCESS
    #  domain=test-api-domain11.com
    #  registrystatus_0=clientTransferProhibited
    #
    def registry_status(domain_name_with_tld)
      if check_domain_format(domain_name_with_tld) == false
        raise InvalidInputParameters.new("Invalid domain format. Please use this format: example.net")
      end

      options = {"Domain" => domain_name_with_tld}
      connection = Connection.new
      connection.post("Domain/RegistryStatus", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/08_domain_push
    #
    # /Domain/Push
    #
    # The command is intended to move a domain from one account to another.
    # Please note that while you change the account that is responsible for
    # managing the domain, the simple action of pushing a domain is not
    # automatically changing the official Registrant/Admin contact. To update
    # the Registrant/Admin contact or other contacts for a domain use instead
    # /Domain/Update or /Domain/Trade if you want to change the registrant name
    # for .fr and .eu.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name
    #
    # Example return data:
    #
    #  transactid=b4abf0a27dbb049a7c69cbcbe10247cd
    #  status=SUCCESS
    #  domain=example.com
    #
    def push_domain(domain_name_with_tld, destination)
      if destination.nil? && check_domain_format(domain_name_with_tld) == false
        raise InvalidInputParameters.new("Destination is a required parameter") if destination.nil?
        raise InvalidInputParameters.new("Invalid domain format. Please use this format: example.net")
      end

      options = {"Domain" => domain_name_with_tld, "Destination" => destination}
      connection = Connection.new
      connection.post("Domain/Push", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/01_domain_related/09_domain_count
    #
    # /Domain/Count
    #
    # The command is intended to count total number of domains in the account.
    # It also returns the number of domains from each extension.
    #
    # Returned data:
    #
    #  TRANSACTID=Transaction ID reference
    #  STATUS=SUCCESS or FAILURE
    #  [extension]=number of domains
    #  TotalDomains=no of total domains or 0
    #
    # Example return data:
    #
    #  transactid=6152fb02df770d12a27700cd643fa5fd
    #  status=SUCCESS
    #  asia=50
    #  bd=1
    #  biz=91
    #  cc=28
    #  com=486
    #  eu=226
    #  fr=245
    #  in=8
    #  info=227
    #  mobi=108
    #  net=278
    #  org=235
    #  tel=1
    #  tv=29
    #  uk=172
    #  totaldomains=2185
    #
    def count_domains
      options = {}
      connection = Connection.new
      connection.post("Domain/Count", options)
    end
  end
end
