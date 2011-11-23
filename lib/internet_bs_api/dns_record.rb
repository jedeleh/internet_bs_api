require "#{Rails.root}/lib/internet_bs_api/connection.rb"
require "#{Rails.root}/lib/internet_bs_api/exception.rb"
require "#{Rails.root}/lib/internet_bs_api/utilities.rb"

module InternetBsApi
  module Domain

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/05_dns_management_related/01_domain_dns_record_add
    #
    # /Domain/DnsRecord/Add
    #
    # The command is intended to add a new DNS record to a specific zone (domain).
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #
    # Example return data:
    #  transactid=c283a85cc044c43585a13ebb1e701002
    #  status=SUCCESS
    #
    def add_dns_record(full_record_name, type, value, ttl_optional, priority_optional, dyn_dns_login, dyn_dns_password)
      validate_list([["FullRecordName", full_record_name, :presence],
        ["Type", type, :dns_record_type],
        ["Value", value, :presence],
        ["DynDnsLogin", value, :presence],
        ["DynDnsPassword", value, :presence]
      ])

      options = {
        "FullRecordName" => full_record_name,
        "Type" => type,
        "Value" => value
      }
      # optional options
      optional_fields = [ ["Ttl", ttl_optional],
        ["Priority", priority_optional],
        ["DynDnsLogin", dyn_dns_login],
        ["DynDnsPassword", dyn_dns_password]
      ]
      options = set_optional_fields(optional_fields, options)

      connection = Connection.new
      connection.post("Domain/DnsRecord/Add", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/05_dns_management_related/02_domain_dns_record_remove
    #
    # /Domain/DnsRecord/Remove
    #
    # The command is intended to remove a DNS record from a specific zone.
    #
    # While the command accepts the same parameters as /Domain/DnsRecord/Add,
    # you only need to pass the credentials (API Key and Password), the
    # FullRecordName and Type, all other parameters are optional and are
    # required only when there is a possibility of ambiguity, example you may
    # have multiple A record for www.example.com for load balancing purposes,
    # consequently you need to pass the Value parameter in order to remove the
    # correct A record. If you do not pass any optional parameter all matching
    # FullRecordName for the specific Type will be removed.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #
    # Example return data:
    #  transactid=c283a85cc044c43585a13ebb1e701002
    #  status=SUCCESS
    #
    def remove_dns_record( full_record_name, type, value_optional, ttl_optional, priority_optional )
      validate_list([["FullRecordName", full_record_name, :presence],
        ["Type", type, :dns_record_type]
      ])

      options = {
        "FullRecordName" => full_record_name,
        "Type" => type
      }
      # optional options
      optional_fields = [ ["Value", value_optional], ["Ttl", ttl_optional], ["Priority", priority_optional]]
      options = set_optional_fields(optional_fields, options)

      connection = Connection.new
      connection.post("Domain/DnsRecord/Remove", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/05_dns_management_related/03_domain_dns_record_update
    #
    # /Domain/DnsRecord/Update
    #
    # The command is intended to update an existing DNS record.
    #
    # Only the credentials (API Key and Password), FullRecordName, Type and
    # NewValue are required, all other parameters are only needed if there is a
    # risk of ambiguity, in particular when you have advanced DNS record used
    # for load balancing. We recommend to always passing as many optional
    # parameters as possible to avoid updating a different record from the one
    # that you originally intended to.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #
    # Example return data:
    #  transactid=c283a85cc044c43585a13ebb1e701002
    #  status=SUCCESS
    #
    def update_dns_record(full_record_name, type, new_value,
                         current_value_optional, current_ttl_optional, current_priority_optional, current_dyn_dns_login,
                         current_dyn_dns_password,
                         new_ttl_optional, new_priority, new_dyn_dns_login_optional, new_dyn_dns_password_optional)
      validate_list([["FullRecordName", full_record_name, :presence],
        ["Type", type, :dns_record_type],
        ["NewValue", new_value, :presence]
      ])
      options = {
        "FullRecordName" => full_record_name,
        "Type" => type,
        "NewValue" => new_value
      }
      # optional options
      optional_fields = [ ["CurrentValue", current_value_optional],
        ["CurrentTtl", current_ttl_optional],
        ["CurrentPriority", current_priority_optional]],
        ["CurrentDynDnsLogin", current_dyn_dns_login_optional],
        ["CurrentDynDnsPassword", current_dyn_dns_password_optional]
      ]
      options = set_optional_fields(optional_fields, options)

      connection = Connection.new
      connection.post("Domain/DnsRecord/Update", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/05_dns_management_related/04_domain_dns_record_list
    #
    # /Domain/DnsRecord/List
    #
    # The command is intended to retrieve the list of DNS records for a specific domain
    #
    # Example returned data:
    #  transactid=0c3a4efc0c44d81c4e1a06b9094d7523
    #  status=SUCCESS
    #  total_records=3
    #  records_0_name=w1.test-api-domain7.net
    #  records_0_value=www.internet.bs
    #  records_0_ttl=3600
    #  records_0_type=CNAME
    #  records_1_name=w2.test-api-domain7.net
    #  records_1_value=www.internet.bs
    #  records_1_ttl=3600
    #  records_1_type=CNAME
    #  records_2_name=w3.test-api-domain7.net
    #  records_2_value=internet.bs
    #  records_2_ttl=3600
    #  records_2_type=CNAME
    #
    def list_dns_records(domain, filter_type_optional
      validate_list([["Domain", domain, :domain_format]])
      options = { "Domain" => domain }

      # optional options
      optional_fields = [ ["FilterType", filter_type_optional] ]
      options = set_optional_fields(optional_fields, options)

      connection = Connection.new
      connection.post("Domain/DnsRecord/List", options)
    end

  end
end
