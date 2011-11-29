require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api/contact.rb"
require "#{Rails.root}/lib/internet_bs_api/exceptions.rb"

describe Contact do
  describe "#to_query" do
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

  describe "#to_options" do
    it "returns a valid hash" do
      valid_contact = initialize_valid_contact
      expected_hash = {
        "Admin_FirstName" => valid_contact.first_name,
        "Admin_LastName" => valid_contact.last_name,
        "Admin_Email" => valid_contact.email,
        "Admin_PhoneNumber" => valid_contact.phone_number,
        "Admin_Street" => valid_contact.street,
        "Admin_City" => valid_contact.city,
        "Admin_CountryCode" => valid_contact.country_code,
        "Admin_PostalCode" => valid_contact.postal_code
      }
      valid_contact.to_options().should == expected_hash
    end
  end
end
