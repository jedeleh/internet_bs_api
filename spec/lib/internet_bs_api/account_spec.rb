require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api.rb"
require "#{Rails.root}/lib/internet_bs_api/account.rb"


class AccountApi
  include InternetBsApi::Account
end

describe "Account API" do
  describe "#get_balance" do
    it "returns valid response values" do
      api = AccountApi.new
      response = api.get_balance nil
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["balance"].size.should == 1
      response["balance"][0].size.should == 2
    end

    it "handles the optional currency flag" do
      api = AccountApi.new
      response = api.get_balance "EUR"
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["balance"].size.should == 1
      response["balance"][0].size.should == 2
      response["balance"][0]["currency"].should == "EUR"
    end
  end

  describe "#get_default_currency" do
    it "returns valid reponse values" do
      api = AccountApi.new
      response = api.get_default_currency
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["currency"].should_not be_nil
    end
  end

  describe "#set_default_currency" do
    it "returns valid reponse values" do
      api = AccountApi.new
      response = api.set_default_currency "EUR"
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end

    it "returns failure for invalid currency type" do
      api = AccountApi.new
      response = api.set_default_currency "SUPERCALI"
      response.code.should == 200
      response["status"].should == "FAILURE"
    end
  end

  describe "#get_configuration" do
    it "returns valid reponse values" do
      api = AccountApi.new
      response = api.get_configuration
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["transactid"].should_not be_nil
      response["transferapprovalcss"].should ==  "h1{color:red}"
      response["resellername"] == "testName"
      response["resellersenderemail"] == "test@sender.com"
      response["resellerwhoisheader"] == "customwhoisheader"
    end
  end

  describe "#set_configuration" do
    it "returns valid reponse values" do
      api = AccountApi.new
      response = api.set_configuration("h1{color:red}", "booger", "a@b.com", "c@d.com", "foo", "bar")
      response.code.should == 200
      response["status"].should == "SUCCESS"
    end
  end

  describe "#get_price_list" do
    it "returns valid reponse values with no optional parameters" do
      api = AccountApi.new
      response = api.get_price_list(nil, nil, nil)
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["product"].size.should > 0
    end

    it "returns valid reponse values with an optional parameter" do
      api = AccountApi.new
      response = api.get_price_list(nil, "USD", "1")
      response.code.should == 200
      response["status"].should == "SUCCESS"
      response["product"].size.should > 1
    end
  end

  describe "#get_transaction_info" do
    it "returns FAILURE if neither transaction id nor client transaction id are specified" do
      api = AccountApi.new
      response = api.get_transaction_info(nil, nil, nil)
      response.code.should == 200
      response["status"].should == "FAILURE"
    end

    it "returns valid json if one of the transaction id values is set" do
      api = AccountApi.new
      response = api.set_configuration("h1{color:red}", "booger", "a@b.com", "c@d.com", "foo", "bar")
      response = api.get_transaction_info(response["transactid"], nil, nil)
      y response
      response.code.should == 200
      response["status"].should == "SUCCESS"

    end
  end
end
