require "#{Rails.root}/lib/internet_bs_api/connection.rb"
require "#{Rails.root}/lib/internet_bs_api/exception.rb"
require "#{Rails.root}/lib/internet_bs_api/utilities.rb"

module InternetBsApi
  module Domain

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/05_dns_management_related/01_domain_dns_record_add
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
