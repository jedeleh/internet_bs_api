require "#{Rails.root}/lib/internet_bs_api/exceptions.rb"
require "#{Rails.root}/lib/internet_bs_api/utilities.rb"

class Contact
  attr_accessor :first_name, :last_name, :organization, :email, :phone_number, :street, :street2, :street3, :city, :country_code, :postal_code, :contact_type
  REGISTRANT_CONTACT_TYPE = "Registrant_"
  ADMIN_CONTACT_TYPE = "Admin_"
  TECHNICAL_CONTACT_TYPE = "Technical_"
  BILLING_CONTACT_TYPE = "Billing_"

  ALL_CONTACT_TYPES = [
    REGISTRANT_CONTACT_TYPE,
    ADMIN_CONTACT_TYPE,
    TECHNICAL_CONTACT_TYPE,
    BILLING_CONTACT_TYPE
  ]

  def to_query(contact_type)
    # make sure that the options are all there
    #
    bad_options = validate
    if bad_options.length > 0
      exception_string = "There are required options that are missing: #{bad_options.join(",")}"
      raise InvalidContactException.new(exception_string)
    end

    if contact_type.nil?
      contact_type = this.contact_type
    end

    option_string = "?"
    options = []
    options << "#{contact_type}FirstName=#{first_name}"
    options << "#{contact_type}LastName=#{last_name}"
    options << "#{contact_type}Organization=#{organization}" if organization
    options << "#{contact_type}Email=#{email}"
    options << "#{contact_type}PhoneNumber=#{phone_number}"
    options << "#{contact_type}Street=#{street}"
    options << "#{contact_type}Street2=#{street2}" if street2
    options << "#{contact_type}Street3=#{street3}" if street3
    options << "#{contact_type}City=#{city}"
    options << "#{contact_type}CountryCode=#{country_code}"
    options << "#{contact_type}PostalCode=#{postal_code}"
    "?#{options.join("&")}"
  end

  def to_options
    # make sure that the options are all there
    #
    bad_options = validate
    if bad_options.length > 0
      exception_string = "There are required options that are missing: #{bad_options.join(",")}"
      raise InvalidContactException.new(exception_string)
    end

    options_hash = {}

    options_hash["#{contact_type}FirstName"] = "#{first_name}"
    options_hash["#{contact_type}LastName"] = "#{last_name}"
    options_hash["#{contact_type}Organization"] = "#{organization}" if organization
    options_hash["#{contact_type}Email"] = "#{email}"
    options_hash["#{contact_type}PhoneNumber"] = "#{phone_number}"
    options_hash["#{contact_type}Street"] = "#{street}"
    options_hash["#{contact_type}Street2"] = "#{street2}" if street2
    options_hash["#{contact_type}Street3"] = "#{street3}" if street3
    options_hash["#{contact_type}City"] = "#{city}"
    options_hash["#{contact_type}CountryCode"] = "#{country_code}"
    options_hash["#{contact_type}PostalCode"] = "#{postal_code}"
    options_hash
  end

  def validate
    bad_options = []

    # validate first name
    bad_options << "#{contact_type}FirstName" if first_name.blank?
    bad_options << "#{contact_type}LastName" if last_name.blank?
    bad_options << "#{contact_type}Email" if validate_email(email)
    bad_options << "#{contact_type}PhoneNumber" if validate_phone_number(phone_number)
    bad_options << "#{contact_type}Street" if street.blank?
    bad_options << "#{contact_type}City" if city.blank?
    bad_options << "#{contact_type}CountryCode" if country_code.blank?
    bad_options << "#{contact_type}PostalCode" if postal_code.blank?
    bad_options
  end
end
