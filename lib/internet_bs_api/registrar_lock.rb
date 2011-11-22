module InternetBsApi
  module Domain
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/03_registrar_lock/01_domain_registrar_lock_enable
    #
    def enable_registrar_lock(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/RegistrarLock/Enable", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/03_registrar_lock/02_domain_registrar_lock_disable
    #
    def disable_registrar_lock(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/RegistrarLock/Disable", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/02_private_whois/03_domain_private_whois_status
    #
    def status_registrar_lock(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/RegistrarLock/Status", options)
    end
  end
end
