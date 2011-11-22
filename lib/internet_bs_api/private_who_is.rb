module InternetBsApi
  module Domain
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/02_private_whois/01_domain_private_whois_enable
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
    def disable_private_who_is(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/PrivateWhois/Disable", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/02_private_whois/03_domain_private_whois_status
    #
    def status_private_who_is(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/PrivateWhois/List", options)
    end
  end
end
