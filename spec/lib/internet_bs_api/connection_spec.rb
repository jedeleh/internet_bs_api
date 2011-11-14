require 'spec_helper'
require "#{Rails.root}/lib/registrar/connection.rb"

describe Connection do
  before(:all) do
    @path = "foo/do_something"
    @connection = Connection.new
    @api_key = SETTINGS["internet_bs_api"]["api_key"]
    @password = SETTINGS["internet_bs_api"]["password"]
  end

  describe "#build_get_url" do
    it "builds a simple url" do
      url = @connection.build_get_url(@path, {})
      expected = "https://testapi.internet.bs/foo/do_something?ResponseFormat=JSON&apiKey=#{@api_key}&password=#{@password}"
      url.should == expected
    end

    it "builds url with parameters" do
      parameters = { "Bar" => "test_value", "Baz" => "another_test_value" }

      url = @connection.build_get_url(@path, parameters)
      expected = "https://testapi.internet.bs/foo/do_something?Bar=test_value&Baz=another_test_value&ResponseFormat=JSON&apiKey=#{@api_key}&password=#{@password}"
      url.should == expected
    end
  end

  describe "#build_post_url" do
    it "builds a simple url" do
      url = @connection.build_post_url(@path)
      expected = "https://testapi.internet.bs/foo/do_something?ResponseFormat=JSON&apiKey=#{@api_key}&password=#{@password}"
      url.should == expected
    end
  end

end
