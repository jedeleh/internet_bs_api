require "#{Rails.root}/lib/internet_bs_api/connection.rb"
require "#{Rails.root}/lib/internet_bs_api/exceptions.rb"
require "#{Rails.root}/lib/internet_bs_api/utilities.rb"

module InternetBsApi
  module Account

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/01_account_balance_get
    #
    # /Account/Balance/Get
    #
    # The command is intended to retrieve the prepaid account balance.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #  Balance_<N>_Currency=The currency of the balance
    #  Balance_<N>_amount=The amount available as prepaid balance
    #
    # Example return data:
    #  transactid=6b6f221677db9d6933264b6a5f35ed03
    #  status=SUCCESS
    #  balance_0_currency=EUR #  balance_0_amount=627.1
    #  balance_1_currency=JPY
    #  balance_1_amount=9899378.64
    #
    def get_balance(currency_optional)
      connection = Connection.new
      options = {}
      options["Currency"] = currency_optional if not currency_optional.blank?
      connection.post("Account/Balance/Get", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/02_account_currency_get
    #
    # /Account/DefaultCurrency/Get
    #
    # The command is intended to set the default currency
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #  Currency=The default currency
    #
    # Example return data:
    #  transactid=5c5f9e5637cf5f51e5e20e3ff12105c9
    #  status=SUCCESS
    #  currency=USD
    #
    def get_default_currency
      connection = Connection.new
      connection.post("Account/DefaultCurrency/Get", {})
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/03_account_currency_set
    #
    # /Account/DefaultCurrency/Set
    #
    # The command is intended to set the default currency. The default currency
    # is used when you have available balances in multiple currencies. In this
    # case the prepaid funds in the default currency are used.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #
    # Example return data:
    #  transactid=c283a85cc044c43585a13ebb1e701002
    #  status=SUCCESS
    #
    def set_default_currency(currency)
      validate_list([["Currency", currency, :presence]])

      connection = Connection.new
      options = {"Currency" => currency}
      connection.post("Account/DefaultCurrency/Set", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/04_account_configuration_get
    #
    # /Account/Configuration/Get
    #
    # The command is intended to view the account configuration. The values for
    # all configuration options are returned. For the moment it supports
    # TransferApprovalCss, resellerName, resellerSenderEmail,
    # resellerSupportEmail, resellerWhoisHeader and resellerWhoisFooter.
    #
    # Example return data:
    #  transactid=8bb0eb0edcafd3d4ce54109109ec88dc
    #  transferapprovalcss=h2{color:red}\nh3{color blue}\nh4{color:black}
    #  resellername=Best domains
    #  resellersenderemail=no-reply@example.com
    #  resellersupportemail=support@example.com
    #  resellerwhoisheader=Registration service provided by: Best domains\nWebsite=http://www.example.com
    #  resellerwhoisfooter=For any questions contact us at: best domains<support@example.com>
    #  status=SUCCESS
    #
    def get_configuration
      connection = Connection.new
      connection.post("Account/Configuration/Get", {})
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/05_account_configuration_set
    #
    # /Account/Configuration/Set
    #
    # The command allows you to set the available configuration values for the API.
    #
    # returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #
    # Example return data:
    #  transactid=14da56853f755140bee198b641fc1494
    #  status=SUCCESS
    #
    def set_configuration(transfer_approval_css,
                          reseller_name,
                          reseller_sender_email,
                          reseller_support_email,
                          reseller_whois_header,
                          reseller_whois_footer)
      # validation
      validate_list([["TransferApprovalCss", transfer_approval_css, :presence],
        ["ResellerName", reseller_name, :presence],
        ["ResellerSenderEmail", reseller_sender_email, :email],
        ["ResellerSupportEmail", reseller_support_email, :email],
        ["ResellerWhoisHeader", reseller_whois_header, :presence],
        ["ResellerWhoisFooter", reseller_whois_footer, :presence]
      ])

      options = {
        "TransferApprovalCss" => transfer_approval_css,
        "ResellerName" => reseller_name,
        "ResellerSenderEmail" => reseller_sender_email,
        "ResellerSupportEmail" => reseller_support_email,
        "ResellerWhoisHeader" => reseller_whois_header,
        "ResellerWhoisFooter" => reseller_whois_footer
      }
      connection = Connection.new
      connection.post("Account/Configuration/Set", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/06_account_price_list_get
    #
    # /Account/PriceList/Get
    #
    # The command is intended to obtain our pricelist.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #  Currency=The price currency
    #  Product=The product (ex: .com registration, .com renewal, .com transfer)
    #  Price=The price in the Currency
    #
    # Example return data:
    #  transactid=9f02bff265d0ee1fd50900dd2701f09b
    #  status=SUCCESS
    #  product_0_name=.in registration
    #  product_0_price=4.91
    #  product_0_currency=CAD
    #  product_1_name=.ind.in renewal
    #  product_1_price=14.80
    #  product_1_currency=CAD
    #  ...
    #  product_n_name=.ind.in registration
    #  product_n_price=14.80
    #  product_n_currency=CAD
    #  product_n_name=.org.in transfer
    #  product_n_price=14.80
    #  product_n_currency=CAD
    #
    def get_price_list(discount_code_optional, currency_optional, version_optional)
      options = {}
      options["discountCode"] = discount_code_optional if discount_code_optional
      options["Currency"] = currency_optional if currency_optional
      options["version"] = version_optional if version_optional
      connection = Connection.new
      connection.post("Account/PriceList/Get", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/07_account_transaction_info
    #
    # /Account/TransactionInfo/Get
    #
    # The command is intended to view the transaction details. This means it
    # will be able to return the response returned when the transaction was
    # executed. It can return the exact response as when it was called. It can
    # return the same data but in a chosen format or it can return the
    # parameters sent by the client in the format specified.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #  TRANSACTION_STATUS = PENDING, COMPLETED or FAILED
    #  Additional response fields depend on the transaction identified by the TransactionId parameter.
    #
    def get_transaction_info(transaction_id_optional, client_transaction_id_optional, response_type_optional)
      options = {}
      options["TransactionID"] = transaction_id_optional if transaction_id_optional
      options["ClientTransactionId"] = client_transaction_id_optional if client_transaction_id_optional
      options["ResponseType"] = response_type_optional if response_type_optional

      connection = Connection.new
      connection.post("Account/TransactionInfo/Get", options)
    end
  end
end
