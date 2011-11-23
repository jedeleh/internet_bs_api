module InternetBsApi
  module Domain
    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/05_domain_url_forward_add
    #
    # /Domain/UrlForward/Add
    #
    # The command is intended to add a new URL Forwarding rule.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #
    # Example return data:
    #  transactid=c283a85cc044c43585a13ebb1e701002
    #  status=SUCCESS
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
    # /Domain/UrlForward/Remove
    #
    # The command is intended to remove an existing URL Forwarding rule.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #
    # Example return data:
    #  transactid=c283a85cc044c43585a13ebb1e701002
    #  status=SUCCESS
    #
    def remove_url_forward
      validate_list( [ ["Source", source, :url_format] ])
      options = {"Source" => source}

      connection = Connection.new
      connection.post("Domain/UrlForward/Remove", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/07_domain_url_forward_update
    #
    # /Domain/UrlForward/Update
    #
    # The command is intended to update an existing URL Forwarding rule.
    #
    # It takes exactly the same parameters as /Domain/UrlForward/Add. In order
    # to update a rule you have to specify as a source an existing URL
    # Forwarding rule. Besides the credentials only the source is mandatory
    # plus one or more extra parameters of your choice. The original rule will
    # be updated according to the new values you set, everything else will stay
    # unchanged. Consequently you can simply update the parameter siteTitle or
    # Destination while all other parameters will stay the same for the
    # specific rule identified by the Source parameter.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID reference
    #
    # Example return data:
    #  transactid=c283a85cc044c43585a13ebb1e701002
    #  status=SUCCESS
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
    # /Domain/UrlForward/List
    #
    # The command is intended to retrieve the list of URL forwarding rules for a domain.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID
    #  RULE_[x]_SOURCE = the source for the rule [x] where [x] is a number starting with 1 and incrementing for each rule
    #  RULE_[x]_DESTINATION = the destination for rule [x]
    #  RULE_[x]_ISFRAMED = YES/NO. If YES the following fields will also be present
    #  RULE_[x]_TITLE = rule [x] title for framed redirect
    #  RULE_[x]_DESCRIPTION = rule [x] meta description for framed redirect
    #  RULE_[x]_KEYWORDS = rule [x] keywords for framed redirect
    #
    # Example return data:
    #  transactid=8263667cb41b45a0e30b3e0032bb0463
    #  total_rules=3
    #  rule_1_source=www.test-api-domain7.net
    #  rule_1_destination=http://www.google.com
    #  rule_1_isframed=YES
    #  rule_1_title=
    #  rule_1_description=
    #  rule_1_keywords=
    #  rule_2_source=w3.test-api-domain7.net
    #  rule_2_destination=http://www.google.com
    #  rule_2_isframed=YES
    #  rule_2_title=
    #  rule_2_description=
    #  rule_2_keywords=
    #  rule_3_source=w8.test-api-domain7.net
    #  rule_3_destination=http://www.google.com
    #  rule_3_isframed=YES
    #  rule_3_title=
    #  rule_3_description=
    #  rule_3_keywords=
    #  status=SUCCESS
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
