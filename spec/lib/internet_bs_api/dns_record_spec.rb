require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api.rb"
require "#{Rails.root}/lib/internet_bs_api/dns_record.rb"


class DnsRecordApi
  include InternetBsApi::Domain
end

describe "DNS Record API" do
  describe "#add_dns_record" do
    it "returns valid response values" do
    end

  end
end
