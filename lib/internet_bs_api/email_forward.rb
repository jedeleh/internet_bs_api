module InternetBsApi
  module Domain

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/01_domain_email_forward_add
    #
    def add_email_forward(source, destination)
      validate_list([["Source", source, :email],
        ["Destination", destination, :email]
      ])

      options = {
        "Source" => source,
        "Destination" => destination
      }

      connection = Connection.new
      connection.post("Domain/EmailForward/Add", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/02_domain_email_forward_remove
    #
    def remove_email_forward(source)
      validate_list([["Source", source, :email] ])

      options = { "Source" => source }

      connection = Connection.new
      connection.post("Domain/EmailForward/Remove", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/03_domain_email_forward_update
    #
    def update_email_forward(source, destination)
      validate_list([["Source", source, :email],
        ["Destination", destination, :email]
      ])

      options = {
        "Source" => source,
        "Destination" => destination
      }

      connection = Connection.new
      connection.post("Domain/EmailForward/Update", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/04_domain_email_forward_list
    #
    def list_email_forwards(domain, range_from_optional, range_to_optional)
      validate_list([ ["Domain", domain, :domain_format] ])
      options = { "Domain" => domain }
      optional_fields = [ ["rangeFrom", range_from_optional], ["rangeTo", range_to_optional] ]
      options = set_optional_fields(optional_fields, options)

      connection = Connection.new
      connection.post("Domain/EmailForward/List", options)
    end
  end
end
