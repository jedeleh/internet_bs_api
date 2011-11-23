module InternetBsApi
  module Domain
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/07_nameservers_related/01_domain_host_create
    #
    # /Domain/Host/Create
    #
    # The command is intended to create a host also known as name server or child host.
    #
    # The host will be created under the same Registry the domain belongs to
    # (.com host under .com Registry, .net host under .net Registry, .biz host
    # under .biz Registry and so on...).
    #
    # You do not need to create a host under a different Registry from the
    # domain extension of the host itself as we automatically create it
    # whenever needed. For example you only need to create a host if you wish
    # to declare the new name server ns1.example.com under the .com Registry,
    # while you can freely use ns1.example.com under any other extension such
    # as .uk or .biz or .info or .fr, etc...
    #
    # Note that if you are using existing hosts (name servers) already created
    # by your hosting company or another Registrar, you wont need to create
    # them again, actually you wont even be able to create them as you have no
    # authority for the root domain. You can only create hosts for domains that
    # belong to you and are managed by us.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #
    # Example return data:
    #  transactid=c283a85cc044c43585a13ebb1e701002
    #  status=SUCCESS
    #
    def create_host(host, ip_list)
      validate_list([["Host", host, :presence], ["IP_List", ip_list, :presence]])
      options = {"Host" => host, "IP_List" => ip_list}

      connection = Connection.new
      connection.post("Domain/Host/Create", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/07_nameservers_related/02_domain_host_update
    #
    # /Domain/Host/Update
    #
    # The command is intended to update a host; the command is replacing the
    # current list of IP for the host with the new one you provide. It is
    # accepting the same parameters as domainHostCreate and will return the
    # same results.
    #
    # Returned data:
    #  STATUS=SUCCESS or PENDING or FAILURE
    #  TRANSACTID=Transaction ID
    #  HOST=The host name
    #  IP1=IP address
    #  ...
    #  ...
    #  IP_<N>= IP address
    #
    # Example return data:
    #  transactid=f0c548d2b3f8ecc25a5c1d94c3782173
    #  status=SUCCESS
    #  host=ns1.test-api-domain7.net
    #  ip_0=221.11.21.13
    #  ip_1=194.221.22.32
    #
    def update_host(host, ip_list)
      validate_list([["Host", host, :presence], ["IP_List", ip_list, :presence]])
      options = {"Host" => host, "IP_List" => ip_list}

      connection = Connection.new
      connection.post("Domain/Host/Update", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/07_nameservers_related/03_domain_host_info
    #
    # /Domain/Host/Info
    #
    # The command is intended to retrieve existing host (name server) information for a specific host
    #
    # Returned data:
    #
    #  STATUS=SUCCESS or PENDING or FAILURE
    #  TRANSACTID=Transaction ID
    #  HOST=The host name
    #  IP1=IP address
    #  ...
    #  ...
    #  IP_<N>= IP address
    #
    #  Example return data:
    #  transactid=ef24193543d7f581777b5a73318a6f8b
    #  status=SUCCESS
    #  host=ns1.test-api-domain7.net
    #  ip_0=121.211.42.77
    #  ip_1=144.222.21.92
    #  Execution_time=0.046873807907104
    #
    def info_host(host)
      validate_list([["Host", host, :presence]])
      options = {"Host" => host}

      connection = Connection.new
      connection.post("Domain/Host/Info", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/07_nameservers_related/04_domain_host_delete
    #
    # /Domain/Host/Delete
    #
    # The command is intended to delete (remove) an unwanted host. Note if your
    # host is currently used by one or more domains the operation will fail.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #
    # Example return data:
    #  transactid=c283a85cc044c43585a13ebb1e701002
    #  status=SUCCESS
    #
    def delete_host
      validate_list([["Host", host, :presence]])
      options = {"Host" => host}

      connection = Connection.new
      connection.post("Domain/Host/Delete", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/07_nameservers_related/05_domain_host_list
    #
    # /Domain/Host/List
    #
    # The command is intended to retrieve the list of hosts defined for a domain.
    #
    # Returned data:
    #  STATUS=SUCCESS or PENDING or FAILURE
    #  TRANSACTID=Transaction ID
    #  HOSTCOUNT =A value <N> representing the number of hosts found for the domain.
    #  HOST1=hostname1.domain.tld
    #  HOST1_IPCount=A value <X> representing the number of IP found for the host.
    #  HOST1_IP1=IP
    #  ...
    #  HOST1_IP<X>=IP
    #  ...
    #  ...
    #  HOST<N>=hostnameN.domain.tld
    #
    # Example return data for CompactList=yes
    #  transactid=c83ac6a6be45f3198ac8204f7151f517
    #  status=SUCCESS
    #  total_hosts=5
    #  host_1=ns1.test-api-domain7.net
    #  host_2=ns2.test-api-domain7.net
    #  host_3=ns3.test-api-domain7.net
    #  host_4=ns4.test-api-domain7.net
    #  host_5=ns5.test-api-domain7.net
    #
    # Example return data for with CompactList=no:
    #  transactid=01806c59e8a5c0de1981a5148e2d9d29
    #  status=SUCCESS
    #  total_hosts=5
    #  host_1_hostname=ns1.test-api-domain7.net
    #  host_1_ipcount=2
    #  host_1_ip_1=121.211.42.77
    #  host_1_ip_2=144.222.21.92
    #  host_2_hostname=ns2.test-api-domain7.net
    #  host_2_ipcount=2
    #  host_2_ip_1=121.211.42.77
    #  host_2_ip_2=144.222.21.92
    #  host_3_hostname=ns3.test-api-domain7.net
    #  host_3_ipcount=2
    #  host_3_ip_1=121.211.42.77
    #  host_3_ip_2=144.222.21.92
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
