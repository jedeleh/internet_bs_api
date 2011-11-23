require "#{Rails.root}/lib/internet_bs_api/connection.rb"
require "#{Rails.root}/lib/internet_bs_api/exception.rb"
require "#{Rails.root}/lib/internet_bs_api/utilities.rb"

module InternetBsApi
  module Domain

    # NOTE: two API calls are not current supported as they are Europe specific:
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/08_domain_trade
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/09_domain_change_tag_uk
    #   these should be implemented if anyone tackles adding EU support to the gem
    #

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/01_domain_transfer_initiate
    #
    # /Domain/Transfer/Initiate
    #
    # The command is intended to initiate an incoming domain name transfer.
    #
    # The parameters are almost identical to those used for /Domain/Create,
    # however some extra parameters are optionally offered. Please pay
    # attention as the parameter transferAuthInfo is not always optional. For
    # reference see comments in the table below. Because of some structural
    # differences between domain extensions, the parameter Period is not
    # accepted; once a transfer has been completed you can use /Domain/Renew to
    # extend the expiration if needed.
    #
    # Returned data:
    #  STATUS=SUCCESS or PENDING or FAILURE
    #  TRANSACTID=Transaction ID reference
    #  Domain=Domain name

    # Example return value:
    #  transactid=d47317a3902d83b8df88ae9337a9359d
    #  currency=USD
    #  price=6.99
    #  product_0_price=6.99
    #  product_0_status=SUCCESS
    #  product_0_domain=example.eu
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
    # /Domain/Transfer/Cancel
    #
    # The command is intended to cancel a pending incoming transfer request. If successful the corresponding amount will be returned to your pre-paid balance.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name

    # Example return data:
    #  STATUS=SUCCESS
    #  TRANSACTID= xdert345sdfryuh
    #  Domain=example.com
    #
    def cancel_transfer(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/Transfer/Cancel", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/03_domain_transfer_resend_auth_email
    #
    # /Domain/Transfer/ResendAuthEmail
    #
    # The command is intended to resend the Initial Authorization for the
    # Registrar Transfer email for a pending, incoming transfer request. The
    # operation is possible only if the current request has not yet been
    # accepted/rejected by the Registrant/Administrative contact, as it would
    # make no sense to ask again.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name

    # Example return data:
    #  STATUS=SUCCESS
    #  TRANSACTID= xdert345sdfryuh
    #  Domain=example.com
    #
    def resend_auth_email_transfer(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/Transfer/ResendAuthEmail", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/06_domain_transfer_history
    #
    # /Domain/Transfer/History
    #
    # The command is intended to retrieve the history of a transfer.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name
    #  History_[number]_Date = date in yyyy/mm/dd format
    #  History_[number]_StatusMessage = text transfer status
    #  History_[number]_StatusCode = status code
    #  History_[number]_AdditionalData = auth info or email of the current
    #   registrant/administrative contact
    #  AdditionalData may be empty for some statuses.

    # Example return data:
    #  transactid=6d63a7c894a5fb651ffe81e6375f0489
    #  status=SUCCESS
    #  domain=example.com
    #  history_0_date=2009/03/03
    #  history_0_statusmessage=Transfer fee has been paid
    #  history_0_statuscode=Transfer Paid
    #  history_0_additionaldata=
    #  history_1_date=2009/03/03
    #  history_1_statusmessage=We are extracting the current
    #   Administrative/Registrant contact email address from the public WHOIS in
    #   order to obtain the permission to initiate the transfer as required by
    #   the current legal policies and regulations. Make sure the public WHOIS
    #   data for the domain is up to date and the Administrative/Registrant
    #   contact email address is correct
    #  history_1_statuscode=Acquiring Whois Data
    #  history_1_additionaldata=EPP Auth Info: 123456789
    #
    def history_transfer(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/Transfer/History", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/07_domain_transfer_retry
    #
    # /Domain/Transfer/Retry
    #
    # This command is intended to reattempt a transfer in case an error
    # occurred because inaccurate transfer auth info was provided or because
    # the domain was locked or in some other cases where an intervention by the
    # customer is required before retrying the transfer.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name

    # Example return data:
    #  STATUS=SUCCESS
    #  TRANSACTID= xdert345sdfryuh
    #  Domain=example.com
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
    # /Domain/TransferAway/Approve
    #
    # The command is intended to immediately approve a pending, outgoing
    # transfer request (you are transferring a domain away). The operation is
    # possible only if there is a pending transfer away request from another
    # Registrar. If you do not approve the transfer within a specific time
    # frame, in general 5 days for .com/.net domains, the transfer will
    # automatically be approved by the Registry. If you need to reject a
    # transfer away, use the command /Domain/TransferAway/Reject.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name

    # Example return data:
    #  STATUS=SUCCESS
    #  TRANSACTID= xdert345sdfryuh
    #  Domain=example.com
    #
    def approve_transfer_away(domain)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }

      connection = Connection.new
      connection.post("Domain/TransferAway/Approve", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/04_transfer_trade/05_domain_transfer_away_reject
    #
    # /Domain/TransferAway/Reject
    #
    # The command is intended to reject a pending, outgoing transfer request
    # (you are transferring away a domain). The operation is possible only if
    # there is a pending transfer away request from another Registrar. If you
    # do not reject the transfer within a specific time frame, in general 5
    # days for .com/.net domains, the transfer will be automatically approved
    # by the Registry. If you need to immediately approve a transfer away, use
    # the command /Domain/TransferAway/Approve.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID= Transaction ID reference
    #  Domain=domain name

    # Example return data:
    #  STATUS=SUCCESS
    #  TRANSACTID= xdert345sdfryuh
    #  Domain=example.com
    #
    def reject_transfer_away(domain, reason)
      validate_list([ ["Domain", domain, :domain_format], ["Reason", reason, :presence ])
      options = { "Domain" => domain, "Reason" => reason }

      connection = Connection.new
      connection.post("Domain/TransferAway/Reject", options)
    end
  end
end
