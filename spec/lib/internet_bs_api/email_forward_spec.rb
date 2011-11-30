require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api.rb"
require "#{Rails.root}/lib/internet_bs_api/email_forward.rb"


class EmailForwardApi
  include InternetBsApi::Domain
end

describe "Account API" do
  describe "#add_email_forward" do
    it "returns valid json" do
      # create a valid domain to transfer from
      #
      api = EmailForwardApi.new
      source_domain = create_valid_domain(api, generate_domain)

      # create a valid domain to transfer to
      #
      destination_domain = create_valid_domain(api, generate_domain)

      # now transfer it to another valid domain
      #
      transfer_target_domain = generate_domain
      response = api.add_email_forward("email_1@#{source_domain}", "email_1@#{destination_domain}")
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end

    it "fails for invalid domains" do
      api = EmailForwardApi.new

      source_domain = generate_domain
      destination_domain = generate_domain
      response = api.add_email_forward("email_1@#{source_domain}", "email_1@#{destination_domain}")
      response.code.should == 200
      response["status"].should == "FAILURE"
    end
  end

  describe "#remove_email_forward" do
    it "return valid json for success" do
      api = EmailForwardApi.new

      # we need two valid domains
      #
      source_domain = create_valid_domain(api, generate_domain)
      destination_domain = create_valid_domain(api, generate_domain)

      # must forward an email
      #
      response = api.add_email_forward("email_1@#{source_domain}", "email_1@#{destination_domain}")

      response = api.remove_email_forward("email_1@#{source_domain}")
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end

    it "returns valid json for failure" do
      api = EmailForwardApi.new
      response = api.remove_email_forward("email_1@invalid_domain.com")
      response.code.should == 200
      response["status"].should == "FAILURE"
    end
  end

  describe "#update_email_forward" do
    it "returns valid json for success" do
      api = EmailForwardApi.new

      # we need two valid domains and a forward
      #
      source_domain = create_valid_domain(api, generate_domain)
      destination_domain = create_valid_domain(api, generate_domain)
      api.add_email_forward("email_1@#{source_domain}", "email_1@#{destination_domain}")

      response = api.update_email_forward("email_1@#{source_domain}", "email_3@#{destination_domain}")
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end
  end

  describe "#list_email_forward" do
    it "returns valid json for call without optional parameters" do
      api = EmailForwardApi.new

      # we need two valid domains and a forward
      #
      source_domain = create_valid_domain(api, generate_domain)
      destination_domain = create_valid_domain(api, generate_domain)
      api.add_email_forward("email_1@#{source_domain}", "email_1@#{destination_domain}")

      response = api.list_email_forwards(source_domain, nil, nil)
      response.code.should == 200
      response["total_rules"].should == 1
      response["status"].should == "SUCCESS"
    end
  end
end
