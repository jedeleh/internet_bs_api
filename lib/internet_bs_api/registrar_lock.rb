module InternetBsApi
  module Domain
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/03_registrar_lock/01_domain_registrar_lock_enable
    #
    # /Domain/RegistrarLock/Enable
    #
    # The command is a purposely redundant auxiliary way to enable the
    # RegistrarLock for a specific domain. The command has been implemented
    # only to allow simpler code writing/reading. You can obtain the exact same
    # result using the command /Domain/Update and setting the parameter
    # RegistrarLock to the value enabled. See also
    # /Domain/RegistrarLock/Disable and /Domain/RegistrarLock/Status. Note the
    # command will fail if you try to enable the RegistrarLock for a domain not
    # supporting this feature, for example for a .uk or .fr domain.
    #
    # Returned data:
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name
    #  STATUS=SUCCESS or FAILURE or PENDING. Pending happens when there is a
    #   temporary problem (ex: when registry is not available). When the
    #   temporary problem passes your request will be processed.
    #
    # Example return data:
    #  transactid=a771b9649c262c882587fd32a105db6d
    #  domain=example777123.com
    #  status=SUCCESS
    #
    def enable_registrar_lock(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/RegistrarLock/Enable", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/03_registrar_lock/02_domain_registrar_lock_disable
    #
    # /Domain/RegistrarLock/Disable
    #
    # The command is a purposely redundant auxiliary way to disable the
    # RegistrarLock for a specific domain. The command has been implemented
    # only to allow simpler code writing/reading. You can obtain the exact same
    # result using the command /Domain/Update and setting the parameter
    # RegistrarLock to the value disabled. See also
    # /Domain/RegistrarLock/Enable and /Domain/RegistrarLock/Status. Note the
    # command will fail if you try to disable the RegistrarLock for a domain
    # not supporting this feature, for example for a .uk or .fr domain
    #
    # Returned data:
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name
    #  STATUS=SUCCESS or FAILURE or PENDING. Pending happens when there is a
    #   temporary problem (ex: when registry is not available). When the
    #   temporary problem passes your request will be processed.
    #
    # Example return data:
    #  transactid=a771b9649c262c882587fd32a105db6d
    #  domain=example777123.com
    #  status=SUCCESS
    #
    def disable_registrar_lock(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/RegistrarLock/Disable", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/02_private_whois/03_domain_private_whois_status
    #
    # /Domain/RegistrarLock/Status
    #
    # The command is a purposely redundant auxiliary way to retrieve the
    # current RegistrarLock status for specific domain. The command has been
    # implemented only to allow simpler code writing/reading. You can obtain
    # the exact same result using the command /Domain/Info and reading the
    # parameter RegistrarLock. See /Domain/RegistrarLock/Enable and
    # /Domain/RegistrarLock/Disable. Note the command will fail if you try to
    # retrieve the RegistrarLock status for a domain not supporting this
    # feature, for example for a .uk or .fr domain.
    #
    # Returned data:
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name
    #  STATUS=SUCCESS or FAILURE or PENDING. Pending happens when there is a
    #   temporary problem (ex: when registry is not available). When the
    #   temporary problem passes your request will be processed.
    #
    # Example return data:
    #  transactid=a771b9649c262c882587fd32a105db6d
    #  domain=example777123.com
    #  status=SUCCESS
    #
    def status_registrar_lock(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/RegistrarLock/Status", options)
    end
  end
end
