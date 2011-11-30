require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api.rb"
require "#{Rails.root}/lib/internet_bs_api/private_who_is.rb"

class PrivateWhoIsApi
  include InternetBsApi::Domain
end

describe "Private Whois API" do
  describe "#enable_private_who_is" do
    it "returns valid json on success" do
      api = PrivateWhoIsApi.new
      domain = create_valid_domain(api, generate_domain)

      response = api.enable_private_who_is(domain, nil)
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["privatewhoisstatus"].should == "FULL"
    end

    it "returns good error message on failure" do
      api = PrivateWhoIsApi.new
      domain = generate_domain

      response = api.enable_private_who_is(domain, nil)
      response.code.should == 200
      response["status"].should == "FAILURE"
      response["message"].should == "The domain \"#{domain}\" is not accessible. Permission denied!"
    end
  end
  describe "#disabled_private_who_is" do
    it "returns valid json on success" do
      api = PrivateWhoIsApi.new
      domain = create_valid_domain(api, generate_domain)

      api.enable_private_who_is(domain, nil)
      response = api.disable_private_who_is(domain)
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["privatewhoisstatus"].should == "DISABLE"
    end

  end
  describe "#status_private_who_is" do
    it "returns valid json when domain is enabled" do
      api = PrivateWhoIsApi.new
      domain = create_valid_domain(api, generate_domain)
      api.enable_private_who_is(domain, nil)

      response = api.status_private_who_is domain
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["domain"].should == domain
      response["privatewhoisstatus"].should == "FULL"

    end

    it "returns valid json when domain is disabled" do
      api = PrivateWhoIsApi.new
      domain = create_valid_domain(api, generate_domain)
      response = api.status_private_who_is domain
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["domain"].should == domain
      response["privatewhoisstatus"].should == "DISABLED"

    end
  end
end
