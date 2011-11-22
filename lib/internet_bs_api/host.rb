module InternetBsApi
  module Domain
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/07_nameservers_related/01_domain_host_create
    #
    def create_host(host, ip_list)
      validate_list([["Host", host, :presence], ["IP_List", ip_list, :presence]])
      options = {"Host" => host, "IP_List" => ip_list}

      connection = Connection.new
      connection.post("Domain/Host/Create", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/07_nameservers_related/02_domain_host_update
    #
    def update_host(host, ip_list)
      validate_list([["Host", host, :presence], ["IP_List", ip_list, :presence]])
      options = {"Host" => host, "IP_List" => ip_list}

      connection = Connection.new
      connection.post("Domain/Host/Update", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/07_nameservers_related/03_domain_host_info
    #
    def info_host(host)
      validate_list([["Host", host, :presence]])
      options = {"Host" => host}

      connection = Connection.new
      connection.post("Domain/Host/Info", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/07_nameservers_related/04_domain_host_delete
    #
    def delete_host
      validate_list([["Host", host, :presence]])
      options = {"Host" => host}

      connection = Connection.new
      connection.post("Domain/Host/Delete", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/07_nameservers_related/05_domain_host_list
    #
    def list_host(domain, compact_list_optional)
      validate_list([["Domain", domain, :domain_format]])
      options = {"Domain" => domain}
      optional_fields = [ ["compact_list_optional", compact_list_optional] ]
      options = set_optional_fields(optional_fields, options)

      connection = Connection.new
      connection.post("Domain/Host/List", options)
    end
  end
end
