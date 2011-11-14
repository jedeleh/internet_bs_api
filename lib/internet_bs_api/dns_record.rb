module InternetBsApi
  module Domain
    def add_dns_record(domain_name_with_tld, type, value)
      options = {
        "FullRecordName" => "www.#{domain_name_with_tld}",
        "Type" => type,
        "Value" => value
      }
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
