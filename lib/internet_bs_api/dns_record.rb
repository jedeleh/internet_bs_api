module InternetBsApi
  module Domain
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
      options["Ttl"] => ttl_optional if ttl_optional
      options["Priority"] => priority_optional if priority_optional
      options["DynDnsLogin"] => dyn_dns_login if dyn_dns_login
      options["DynDnsPassword"] => dyn_dns_password if dyn_dns_password

      connection = Connection.new
      connection.post("Domain/DnsRecord/Add", options)
    end

    def remove_dns_record
    end

    def update_dns_record
    end

    def list_dns_records
    end

  end
end
