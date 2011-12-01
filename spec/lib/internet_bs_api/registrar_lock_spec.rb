require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api.rb"
require "#{Rails.root}/lib/internet_bs_api/registrar_lock.rb"

class RegistrarLockApi
  include InternetBsApi::Domain
end

describe "Registrar Lock API" do
  describe "#enable_registrar_lock" do
    it "returns success" do
      api = RegistrarLockApi.new
      domain = create_valid_domain(api, generate_domain)

      response = api.enable_registrar_lock domain
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["domain"].should == domain
    end

    it "returns failure when domain is invalid" do
      api = RegistrarLockApi.new
      domain = generate_domain
      response = api.enable_registrar_lock domain
      response.code.should == 200
      response["status"].should == "FAILURE"
      response["message"].should == "The domain \"#{domain}\" is not accessible. Permission denied!"
    end
  end

  describe "#disable_registrar_lock" do
    it "returns success" do
      api = RegistrarLockApi.new
      domain = create_valid_domain(api, generate_domain)
      api.enable_registrar_lock domain

      response = api.disable_registrar_lock domain
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["domain"].should == domain
    end

    it "returns failure for invalid domain" do
      api = RegistrarLockApi.new
      domain = generate_domain

      response = api.disable_registrar_lock domain
      response.code.should == 200
      response["status"].should == "FAILURE"
      response["message"].should == "The domain \"#{domain}\" is not accessible. Permission denied!"
    end
  end

  describe "#status_registrar_lock" do
    it "returns valid status information for locked domain" do
      api = RegistrarLockApi.new
      domain = create_valid_domain(api, generate_domain)
      api.enable_registrar_lock domain

      response = api.status_registrar_lock domain
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["domain"].should == domain
      response["registrar_lock_status"].should == "LOCKED"
    end

    it "returns valid status information for unlocked domain" do
      api = RegistrarLockApi.new
      domain = create_valid_domain(api, generate_domain)
      api.disable_registrar_lock domain

      response = api.status_registrar_lock domain
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["domain"].should == domain
      response["registrar_lock_status"].should == "UNLOCKED"
    end

    it "returns FAILURE for non-existent domain" do
      api = RegistrarLockApi.new
      domain = generate_domain

      response = api.status_registrar_lock domain
      response.code.should == 200
      response["status"].should == "FAILURE"
      response["message"].should == "The domain \"#{domain}\" is not accessible. Permission denied!"
    end
  end
end
