require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api.rb"
require "#{Rails.root}/lib/internet_bs_api/transfer.rb"

class TransferApi
  include InternetBsApi::Domain
end

# TODO: I'm not entirely sure what the test workflow for this would be...I
# understand it in a live environment but in terms of test data, what needs to
# be setup etc.
describe "Transfer API" do
  describe "#initiate_transfer" do
    it "returns valid response on success" do
      api = TransferApi.new
      #domain = generate_domain
      domain = "google.com"

      response = api.initiate_transfer(domain, nil, nil, nil, nil, nil, nil, nil)
      response.code.should == 200
    end

    it "returns valid response on success with some optional parameters" do
      api = TransferApi.new
      domain = create_valid_domain(api, generate_domain)

    end

    it "returns valid response on failure" do
      api = TransferApi.new
      domain = create_valid_domain(api, generate_domain)

    end
  end

  describe "#cancel_transfer" do
    it "returns valid response on success" do
      api = TransferApi.new
      domain = create_valid_domain(api, generate_domain)
    end

    it "returns valid response on failure" do
    end
  end

  describe "#resend_auth_email_transfer" do
    it "returns valid response on success" do
      api = TransferApi.new
      domain = create_valid_domain(api, generate_domain)
    end

    it "returns valid response on failure" do
    end
  end

  describe "#history_transfer" do
    it "returns valid response on success" do
      api = TransferApi.new
      domain = create_valid_domain(api, generate_domain)
    end

    it "returns valid response on failure" do
    end
  end

  describe "#retry_transfer" do
    it "returns valid response on success" do
      api = TransferApi.new
      domain = create_valid_domain(api, generate_domain)
    end

    it "returns valid response on failure" do
    end
  end

  describe "approve_transfer_away" do
    it "returns valid response on success" do
      api = TransferApi.new
      domain = create_valid_domain(api, generate_domain)
    end

    it "returns valid response on failure" do
    end
  end

  describe "reject_transfer_away" do
    it "returns valid response on success" do
      api = TransferApi.new
      domain = create_valid_domain(api, generate_domain)
    end

    it "returns valid response on failure" do
    end
  end

end
