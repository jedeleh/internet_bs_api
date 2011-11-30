require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api.rb"
require "#{Rails.root}/lib/internet_bs_api/domain.rb"


class DomainApi
  include InternetBsApi::Domain
end

describe "Domain API" do
  describe "#check_domain" do
    it "returns status AVAILABLE for an available domain" do
      valid_domain = generate_domain
      api = DomainApi.new
      response = api.check_domain(valid_domain)
      response.code.should == 200
      response["status"].should == "AVAILABLE"
    end

    it "returns status UNAVAILABLE for an unavailable domain" do
      valid_domain = "google.com"
      api = DomainApi.new
      response = api.check_domain(valid_domain)
      response.code.should == 200
      response["status"].should == "UNAVAILABLE"
    end
  end

  describe "#create_domain" do
    before(:each) do
      @valid_domain = generate_domain
      api = DomainApi.new
      @contacts = []
      Contact::ALL_CONTACT_TYPES.each do |ct|
        contact = initialize_valid_contact
        contact.contact_type = ct
        @contacts << contact
      end
    end

    it "creates valid output for valid domain" do
      api = DomainApi.new

      response = api.create_domain(@valid_domain, @contacts, nil)
      response.code.should == 200
      products = response["product"]
      products[0]["status"].should == "SUCCESS"
      response["price"].should_not be_nil
      response["currency"].should_not be_nil
    end

    it "accepts clone_contact_domain_optional" do
      # setup
      #
      api = DomainApi.new
      api.create_domain(@valid_domain, @contacts, nil)

      another_valid_domain = generate_domain
      response = api.create_domain(another_valid_domain, nil, @valid_domain)
      response.code.should == 200
      products = response["product"]
      products[0]["status"].should == "SUCCESS"
      response["price"].should_not be_nil
      response["currency"].should_not be_nil

    end

    it "fails on unavailable domain" do
      invalid_domain = "google.com"
      api = DomainApi.new
      response = api.create_domain(invalid_domain, @contacts, nil)
      response.code.should == 200
      response["status"].should == "FAILURE"
    end
  end

  describe "#update_domain" do
    before(:each) do
      @valid_domain = generate_domain
      api = DomainApi.new
      @contacts = []
      Contact::ALL_CONTACT_TYPES.each do |ct|
        contact = initialize_valid_contact
        contact.contact_type = ct
        @contacts << contact
      end
    end

    it "creates valid output" do
      api = DomainApi.new

      api.create_domain(@valid_domain, @contacts, nil)
      response = api.update_domain(@valid_domain, @contacts, nil)
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end
  end

  describe "#renew_domain" do
    before(:each) do
      @valid_domain = generate_domain
      api = DomainApi.new
      @contacts = []
      Contact::ALL_CONTACT_TYPES.each do |ct|
        contact = initialize_valid_contact
        contact.contact_type = ct
        @contacts << contact
      end
    end

    it "creates valid output" do
      api = DomainApi.new
      api.create_domain(@valid_domain, @contacts, nil)
      response = api.renew_domain(@valid_domain, nil, nil)
      response.code.should == 200
      products = response["product"]
      products[0]["status"].should == "SUCCESS"
      response["price"].should_not be_nil
      response["currency"].should_not be_nil
    end

    it "accepts optional parameters" do
    end
  end
end
