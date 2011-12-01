require 'uri'
require 'resolv'
require "#{Rails.root}/lib/internet_bs_api/exceptions.rb"

def check_domain_format(domain_with_tld)
  valid = false
  begin
    uri = URI.parse(domain_with_tld)
    valid = true

    # make sure it is in the "domain.tld" format with no "www", no trailing
    # parameter gunk and no scheme
    valid &&= uri.scheme.blank?
    valid &&= uri.path.blank? == false
    valid &&= uri.host.blank?
    valid &&= uri.path.split(".").length == 2

  rescue URI::InvalidURIError => x
    valid = false
  end
  valid
end

def validate_phone_number(phone_number)
  invalid_format = phone_number.blank?
  #invalid_format ||= (phone_number =~ /^\+1\.\d
end

def validate_email(email_address)
  invalid_format = email_address.blank?
  invalid_format ||= (email_address =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/)
end

def validate_url(url_string)
  valid = false
  if url_string.blank? == false
    begin
      uri = URI.parse(url_string)
      valid = true
    rescue URI::InvalidURIError => x
      valid = false
    end
  end
  valid
end

# validation constants

# enumerations
A_DNS_RECORD_TYPE           = "A"
AAAA_DNS_RECORD_TYPE        = "AAAA"
DYNAMIC_DNS_RECORD_TYPE     = "DYNAMIC"
CNAME_DNS_RECORD_TYPE       = "CNAME"
MX_DNS_RECORD_TYPE          = "MX"
SRV_DNS_RECORD_TYPE         = "SRV"
TXT_DNS_RECORD_TYPE         = "TXT"
NS_DNS_RECORD_TYPE          = "NS"


DNS_RECORD_TYPE_ENUM = [
  A_DNS_RECORD_TYPE,
  AAAA_DNS_RECORD_TYPE,
  DYNAMIC_DNS_RECORD_TYPE,
  CNAME_DNS_RECORD_TYPE,
  MX_DNS_RECORD_TYPE,
  SRV_DNS_RECORD_TYPE,
  TXT_DNS_RECORD_TYPE,
  NS_DNS_RECORD_TYPE
]

def validate_list(fields_list)
  # make sure the list is
  fields_list.each do |l|
    raise ValidationListEntry.new("Bad fields list for nested Array!") if (l.class != Array or l.size != 3)
  end

  bad_fields = []
  fields_list.each do |key,value,validate_method|
    if validate_method == :email
      bad_fields << key if not validate_email(value)
    elsif validate_method == :presence
      bad_fields << key if value.blank?
    elsif validate_method == :dns_record_type
      bad_fields << key if not DNS_RECORD_TYPE_ENUM.include? value
    elsif validate_method == :domain_format
      bad_fields << key if not check_domain_format(value)
    elsif validate_method == :url_format
      bad_fields << key if not validate_url(value)
    end
  end
  if bad_fields.length > 0
    raise InvalidInputParameters.new("Required parameters missing: #{bad_fields}")
  end
end

def set_optional_fields(options_list, options)
  options_list.each do |key, value|
    options[key] = value if value
  end
  options
end

