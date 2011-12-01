require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api.rb"
require "#{Rails.root}/lib/internet_bs_api/url_forward.rb"


class UrlForwardApi
  include InternetBsApi::Domain
end

describe "URL Forward API" do
  describe "#add_url_forward" do
    it "returns valid json" do
      # create a valid domain to transfer from
      #
      api = UrlForwardApi.new
      source_domain = create_valid_domain(api, generate_domain)

      # create a valid domain to transfer to
      #
      destination_domain = create_valid_domain(api, generate_domain)

      # now transfer it to another valid domain
      #
      transfer_target_domain = generate_domain
      response = api.add_url_forward("#{source_domain}", "#{destination_domain}",nil,nil,nil,nil,nil)
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end

    it "fails for invalid domains" do
      api = UrlForwardApi.new

      source_domain = generate_domain
      destination_domain = generate_domain
      response = api.add_url_forward("#{source_domain}", "#{destination_domain}",nil,nil,nil,nil,nil)
      response.code.should == 200
      response["status"].should == "FAILURE"
    end
  end

  describe "#remove_url_forward" do
    it "return valid json for success" do
      api = UrlForwardApi.new

      # we need two valid domains
      #
      source_domain = create_valid_domain(api, generate_domain)
      destination_domain = create_valid_domain(api, generate_domain)

      # must forward an url
      #
      response = api.add_url_forward("#{source_domain}", "#{destination_domain}",nil,nil,nil,nil,nil)

      response = api.remove_url_forward("#{source_domain}")
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end

    it "returns valid json for failure" do
      api = UrlForwardApi.new
      response = api.remove_url_forward("invalid_domain.com")
      response.code.should == 200
      response["status"].should == "FAILURE"
    end
  end

  describe "#update_url_forward" do
    it "returns valid json for success" do
      api = UrlForwardApi.new

      # we need two valid domains and a forward
      #
      source_domain = create_valid_domain(api, generate_domain)
      destination_domain = create_valid_domain(api, generate_domain)
      api.add_url_forward("#{source_domain}", "#{destination_domain}",nil,nil,nil,nil,nil)

      response = api.update_url_forward("#{source_domain}", "#{destination_domain}", nil, nil, nil, nil, nil)
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end
  end

  describe "#list_url_forward" do
    it "returns valid json for call without optional parameters" do
      api = UrlForwardApi.new

      # we need two valid domains and a forward
      #
      source_domain = create_valid_domain(api, generate_domain)
      destination_domain = create_valid_domain(api, generate_domain)
      api.add_url_forward("#{source_domain}", "#{destination_domain}", nil,nil,nil,nil,nil)

      response = api.list_url_forwards(source_domain, nil, nil)
      response.code.should == 200
      response["total_rules"].should == 1
      response["status"].should == "SUCCESS"
    end
  end
end
