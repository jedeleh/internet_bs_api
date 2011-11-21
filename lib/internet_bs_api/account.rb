require "#{Rails.root}/lib/internet_bs_api/connection.rb"
require "#{Rails.root}/lib/internet_bs_api/exception.rb"
require "#{Rails.root}/lib/internet_bs_api/utilities.rb"

module InternetBsApi
  module Account

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/01_account_balance_get
    def get_balance(currency_optional)
      connection = Connection.new
      options = {"Currency" => currency_optional}
      connection.post("Account/Balance/Get", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/02_account_currency_get
    def get_default_currency
      connection = Connection.new
      connection.post("Account/DefaultCurrency/Get", {})
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/03_account_currency_set
    def set_default_currency(currency)
      validate_list([["Currency", currency], :presence])

      connection = Connection.new
      options = {"Currency" => currency}
      connection.post("Account/DefaultCurrency/Set", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/04_account_configuration_get
    def get_configuration
      connection = Connection.new
      connection.post("Account/Configuration/Get", {})
    end

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
        "ResellerName" => reseller_name
        "ResellerSenderEmail" => reseller_sender_email
        "ResellerSupportEmail" => reseller_support_email
        "ResellerWhoisHeader" => reseller_whois_header
        "ResellerWhoisFooter" => reseller_whois_footer
      }
      connection = Connection.new
      connection.post("Account/Configuration/Set", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/06_account_price_list_get
    def get_price_list(discount_code_optional, currency_optional, version_optional)
      options = {}
      options["discountCode"] = discount_code_optional if discount_code_optional
      options["Currency"] = currency_optional if currency_optional
      options["version"] = version_optional if version_optional
      connection = Connection.new
      connection.post("Account/PriceList/Get", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/08_account_related/07_account_transaction_info
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
