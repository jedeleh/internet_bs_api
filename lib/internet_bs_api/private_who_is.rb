require "#{Rails.root}/lib/internet_bs_api/connection.rb"
require "#{Rails.root}/lib/internet_bs_api/exceptions.rb"
require "#{Rails.root}/lib/internet_bs_api/utilities.rb"

module InternetBsApi
  module Domain
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/02_private_whois/01_domain_private_whois_enable
    #
    # /Domain/PrivateWhois/Enable
    #
    # The command is a purposely redundant auxiliary way to enable Private
    # Whois for a specific domain. The command has been implemented only to
    # allow simpler code writing/reading. You can obtain the exact same result
    # invoking the command /Domain/Update and setting the parameter
    # privateWhois to the value FULL or PARTIAL. Note the command will fail if
    # you try to enable Private Whois for a domain not supporting this feature,
    # for example for a .eu domain
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE or PENDING. Pending happens when there is a
    #   temporary problem (ex: when registry is not available). When the
    #   temporary problem passes your request will be processed.
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name

    # Example return data:
    #  transactid=87c7dc1abb6264ce77e9a980123e4399
    #  domain=test-api-domain1.net
    #  status=SUCCESS
    #  privatewhoisstatus=PARTIAL
    #
    def enable_private_who_is(domain, type_optional)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }
      options["type"] = type_optional if type_optional

      connection = Connection.new
      connection.post("Domain/PrivateWhois/Enable", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/02_private_whois/02_domain_private_whois_disable
    #
    # /Domain/PrivateWhois/Disable
    #
    # The command is a purposely redundant auxiliary way to disable Private
    # Whois for a specific domain. The command has been implemented only to
    # allow simpler code writing/reading. You can obtain the exact same result
    # invoking the command /Domain/Update and setting the parameter
    # privateWhois to the value DISABLED. Note the command will fail if you try
    # to disable Private Whois for a domain not supporting this feature, for
    # example for a .eu domain.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE or PENDING. Pending happens when there is a
    #   temporary problem (ex: when registry is not available). When the
    #   temporary problem passes your request will be processed.
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name
    #
    # Example return data:
    #  transactid=87c7dc1abb6264ce77e9a980123e4399
    #  domain=test-api-domain1.net
    #  status=SUCCESS
    #  privatewhoisstatus=DISABLE
    #
    def disable_private_who_is(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/PrivateWhois/Disable", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/02_private_whois/03_domain_private_whois_status
    #
    #  /Domain/PrivateWhois/List
    #
    # The command is a purposely redundant auxiliary way to obtain the Private
    # Whois status for a specific domain. The command has been implemented only
    # to allow simpler code writing/reading. You can obtain the exact same
    # result invoking the command /Domain/Info and extracting the value of
    # privateWhois from the result. Note the command will fail if you try to
    # obtain the Private Whois status for a domain not supporting this feature,
    # for example for a .eu domain.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE or PENDING. Pending happens when there is a
    #   temporary problem (ex: when registry is not available). When the
    #   temporary problem passes your request will be processed.
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name
    #
    # Example return data:
    #  transactid=87c7dc1abb6264ce77e9a980123e4399
    #  domain=test-api-domain1.net
    #  status=SUCCESS
    #  privatewhoisstatus=DISABLE
    #
    def status_private_who_is(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/PrivateWhois/Status", options)
    end
  end
end
