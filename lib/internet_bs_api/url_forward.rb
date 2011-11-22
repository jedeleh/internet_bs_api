module InternetBsApi
  module Domain
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/05_domain_url_forward_add
    #
    def add_url_forward(source, domain,
                        is_framed_optional, site_title_optional, meta_description_optional,
                        meta_keywords_optional, redirect_301_optional )
      validate_list( [ ["Source", source, :url_format], ["Destination", destination, :url_format] ])
      options = {"Source" => source, "Destination" => destination}

      optional_fields = [ ["isFramed", is_framed_optional],
        ["siteTitle", site_title_optional],
        ["metaDescription", site_title_optional],
        ["metaKeywords", meta_keywords_optional],
        ["redirect301", redirect_301_optional]
      ]
      options = set_optional_fields(optional_fields, options)

      connection = Connection.new
      connection.post("Domain/UrlForward/Add", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/06_domain_url_forward_remove
    #
    def remove_url_forward
      validate_list( [ ["Source", source, :url_format] ])
      options = {"Source" => source}

      connection = Connection.new
      connection.post("Domain/UrlForward/Remove", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/07_domain_url_forward_update
    #
    def update_url_forward(source, domain,
                        is_framed_optional, site_title_optional, meta_description_optional,
                        meta_keywords_optional, redirect_301_optional )
      validate_list( [ ["Source", source, :url_format], ["Destination", destination, :url_format] ])
      options = {"Source" => source, "Destination" => destination}

      optional_fields = [ ["isFramed", is_framed_optional],
        ["siteTitle", site_title_optional],
        ["metaDescription", site_title_optional],
        ["metaKeywords", meta_keywords_optional],
        ["redirect301", redirect_301_optional]
      ]
      options = set_optional_fields(optional_fields, options)

      connection = Connection.new
      connection.post("Domain/UrlForward/Update", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/08_domain_url_forward_list
    #
    def list_url_forwards(domain, range_from_optional, range_to_optional)
      validate_list([ ["Domain", domain, :url_format] ])
      options = { "Domain" => domain }
      optional_fields = [ ["rangeFrom", range_from_optional], ["rangeTo", range_to_optional] ]
      options = set_optional_fields(optional_fields, options)

      connection = Connection.new
      connection.post("Domain/UrlForward/List", options)
    end
  end
end
