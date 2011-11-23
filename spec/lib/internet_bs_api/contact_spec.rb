require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api/contact.rb"
require "#{Rails.root}/lib/internet_bs_api/exceptions.rb"

describe Contact do
  describe "#as_query" do
    it "raises InvalidContactException when missing required parameters" do
      contact = Contact.new
      lambda {contact.to_query("Admin_")}.should raise_error
    end

    it "doesn't raise InvalidContactException when missing optional parameters" do
      valid_contact = initialize_valid_contact
      lambda {valid_contact.to_query("Admin_")}.should_not raise_error
    end

    it "returns a valid query string with valid parameters" do
      valid_contact = initialize_valid_contact
      valid_contact.organization = "BigCo"
      valid_contact.street2 = "s2"
      valid_contact.street3 = "s3"
      expected_query_string = "?Admin_FirstName=A" +
              "&Admin_LastName=B" +
              "&Admin_Organization=BigCo" +
              "&Admin_Email=C@D.com" +
              "&Admin_PhoneNumber=+1.2345678912" +
              "&Admin_Street=E" +
              "&Admin_Street2=s2" +
              "&Admin_Street3=s3" +
              "&Admin_City=F" +
              "&Admin_CountryCode=US" +
              "&Admin_PostalCode=98765"

      valid_contact.to_query("Admin_").should == expected_query_string
    end

    it "should raise an error if the email is invalidly formatted" do
      invalid_contact = initialize_valid_contact
      invalid_contact.email = "xxx"
      lambda {valid_contact.to_query("Admin_")}.should raise_error
    end
  end
end

def initialize_valid_contact
  contact = Contact.new

  contact.first_name = "A"
  contact.last_name = "B"
  contact.email = "C@D.com"
  contact.phone_number = "+1.2345678912"
  contact.street = "E"
  contact.city = "F"
  contact.country_code = "US"
  contact.postal_code = "98765"

  contact
end
