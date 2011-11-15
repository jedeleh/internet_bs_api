require 'uri'

def check_domain_format(domain_with_tld)
  valid = false
  domain_url = "http://#{domain_with_tld}"
  begin
    uri = URI.parse(domain_url)
    valid = true
  rescue URI::InvalidURIError => x
    valid = false
  end
  valid
end
