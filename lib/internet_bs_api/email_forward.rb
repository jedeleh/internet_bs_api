module InternetBsApi
  module Domain

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/01_domain_email_forward_add
    #
    # /Domain/EmailForward/Add
    #
    # The command is intended to add a new Email Forwarding rule.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID
    #
    # Example return data:
    #  transactid=5c6690939950db9fad0a667eef0ebd8e
    #  status=SUCCESS
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
    # /Domain/EmailForward/Remove
    #
    # The command is intended to remove an existing Email Forwarding rule.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID
    #
    # Example return data:
    #  transactid=5c6690939950db9fad0a667eef0ebd8e
    #  status=SUCCESS
    #
    def remove_email_forward(source)
      validate_list([["Source", source, :email] ])

      options = { "Source" => source }

      connection = Connection.new
      connection.post("Domain/EmailForward/Remove", options)
    end

    # http://internetbs.net/ResellerRegistrarDomainNameAPI/api/06_forwarding_related/03_domain_email_forward_update
    #
    # /Domain/EmailForward/Update
    #
    # The command is intended to add a new Email Forwarding rule.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  TRANSACTID=Transaction ID
    #
    # Example return data:
    #  transactid=5c6690939950db9fad0a667eef0ebd8e
    #  status=SUCCESS
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
    # /Domain/EmailForward/List
    #
    # The command is intended to retrieve the list of email forwarding rules for a domain.
    #
    # Returned data:
    #  STATUS=SUCCESS or FAILURE
    #  RULE_[x]_SOURCE = the source for the rule [x] where [x] is a number starting with 1 and incrementing for each rule
    #  RULE_[x]_DESTINATION = the destination for rule [x]
    #
    # Example return data:
    #  transactid=b88831878b31225bd9c743b28ac52bf7
    #  total_rules=3
    #  rule_1_source=bbb@test-api-domain7.net
    #  rule_1_destination=myemail@example.com
    #  rule_2_source=@test-api-domain7.net
    #  rule_2_destination=updatedmyemail@example.com
    #  rule_3_source=aaa@test-api-domain7.net
    #  rule_3_destination=myemail@example.com
    #  status=SUCCESS
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
