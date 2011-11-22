module InternetBsApi
  module Domain

    # NOTE: two API calls are not current supported as they are Europe specific:
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/08_domain_trade
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/09_domain_change_tag_uk
    #   these should be implemented if anyone tackles adding EU support to the gem
    #

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/01_domain_transfer_initiate
    #
    def initiate_transfer(domain, ns_list_optional, transfer_auth_info_optional, registrar_lock_optional,
                          private_whois_optional, discount_code_optional, sender_email_optional, sender_name_optional)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      optional_fields = [ ["Ns_list", ns_list_optional],
        ["transferAuthInfo", transfer_auth_info_optional],
        ["registrarLock", registrar_lock_optional],
        ["privateWhois", private_whois_optional],
        ["discountCode", discount_code_optional],
        ["senderEmail", sender_email_optional],
        ["serverName", sender_name_optional]
      ]
      options = set_optional_fields(optional_fields, options)

      connection = Connection.new
      connection.post("Domain/Transfer/Initiate", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/02_domain_transfer_cancel
    #
    def cancel_transfer(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/Transfer/Cancel", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/03_domain_transfer_resend_auth_email
    #
    def resend_auth_email_transfer(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/Transfer/ResendAuthEmail", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/06_domain_transfer_history
    #
    def history_transfer(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/Transfer/History", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/07_domain_transfer_retry
    #
    def retry_transfer(domain, transfer_auth_info_optional)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      optional_fields = [ ["transferAuthInfo", transfer_auth_info_optional] ]
      options = set_optional_fields(optional_fields, options)

      connection = Connection.new
      connection.post("Domain/Transfer/Retry", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/04_domain_transfer_away_approve
    #
    def approve_transfer_away(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/TransferAway/Approve", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/05_domain_transfer_away_reject
    #
    def reject_transfer_away(domain, reason)
      validate_list([ ["Domain", domain, :domain_format], ["Reason", reason, :presence ])
      options = { "Domain" => domain, "Reason" => reason }

      connection = Connection.new
      connection.post("Domain/TransferAway/Reject", options)
    end
  end
end
