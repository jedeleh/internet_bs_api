require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api/utilities.rb"

describe "Utilities" do
  describe "#validate_list" do
    describe "raises an exception for" do
      it "invalid email" do
        options = [["Email", "foo bar", :email]]
        lambda { validate_list(options) }.should raise_error
      end

      it "invalid domain" do
        options = [["Domain", "ren com", :domain_format]]
        lambda { validate_list(options) }.should raise_error
      end

      it "missing, nil or blank parameter" do
        options = [["Required", nil, :presence]]
        lambda { validate_list(options) }.should raise_error
      end

      it "dns record type not in range error" do
        options = [["Enum", "baz", :dns_record_type]]
        lambda { validate_list(options) }.should raise_error
      end
    end

    it "does not raise an exception for valid parameters" do
        options = [
          ["DnsRecordType", "CNAME", :dns_record_type],
          ["Email", "foo@bar.com", :email],
          ["Domain", "foo.com", :domain_format],
          ["Presence", "com", :presence]
        ]
        lambda { validate_list(options) }.should_not raise_error
    end
  end

  describe "#check_domain_format" do
    it "returns false for bad domain" do
      check_domain_format("bad domain name").should be_false
      check_domain_format("www.example.com").should be_false
      check_domain_format("http://www.example.com").should be_false
    end

    it "returns true for valid domain" do
      check_domain_format("example.com").should be_true
    end
  end

  describe "#validate_email" do
    it "returns false for invalid email address" do
      validate_email("foober").should be_false
    end

    it "returns true for valid email address" do
      validate_email("foober@foo.com").should be_true
    end
  end

  describe "#set_optional_fields" do
    it "sets optional fields" do
      options = {}
      optional_fields = [ ["Value1", "value_1"], ["Value2", "value_2"] ]
      options = set_optional_fields(optional_fields, options)
      options.length.should == 2
      options["Value1"].should == "value_1"
      options["Value2"].should == "value_2"
    end
  end
end
