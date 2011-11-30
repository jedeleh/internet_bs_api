require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api.rb"
require "#{Rails.root}/lib/internet_bs_api/host.rb"

class HostApi
  include InternetBsApi::Domain
end

describe "Host API" do
  describe "#create_host" do
    it "returns valid json on success" do
      api = HostApi.new
      domain = create_valid_domain(api, generate_domain)
      response = api.create_host(domain, "1.2.3.4,3.4.5.6")
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end

    it "returns failure status for inaccessible domain" do
      api = HostApi.new
      response = api.create_host("not.com", "1.2.3.4,3.4.5.6")
      response.code.should == 200
      response["status"].should == "FAILURE"
      response["message"].should == "The domain \"not.com\" is not accessible. Permission denied!"
    end
  end

  describe "#update_host" do
    it "returns valid json on success" do
      api = HostApi.new
      domain = create_valid_domain(api, generate_domain)
      response = api.create_host(domain, "1.2.3.4,3.4.5.6")
      response = api.update_host(domain, "1.2.3.4")
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end
  end

  describe "#info_host" do
    it "returns valid json" do
      api = HostApi.new
      domain = create_valid_domain(api, generate_domain)
      api.create_host(domain, "1.2.3.4,3.4.5.6")

      response = api.info_host(domain)
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["ip"][0].should == "1.2.3.4"
      response["ip"][1].should == "3.4.5.6"
    end
  end

  describe "#delete_host" do
    it "returns valid json" do
      api = HostApi.new
      domain = create_valid_domain(api, generate_domain)
      api.create_host(domain, "1.2.3.4,3.4.5.6")

      response = api.delete_host(domain)
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end
  end

  describe "#list_hosts" do
    it "returns valid json" do
      api = HostApi.new
      domain_one = create_valid_domain(api, generate_domain)
      api.create_host(domain_one, "1.2.3.4,3.4.5.6")

      response = api.list_hosts(domain_one, nil)
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["total_hosts"].should == 1
      response["host"]["1"].should == domain_one
    end
  end
end
