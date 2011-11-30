require 'spec_helper'
require "#{Rails.root}/lib/internet_bs_api.rb"
require "#{Rails.root}/lib/internet_bs_api/connection.rb"

describe Connection do
  before(:all) do
    @path = "foo/do_something"
    @connection = Connection.new
  end

  describe "#build_get_url" do
    it "builds a simple url" do
      url = @connection.build_get_url(@path, {})
      expected = "https://testapi.internet.bs/foo/do_something?ResponseFormat=JSON&ApiKey=#{@connection.api_key}&Password=#{@connection.password}"
      url.should == expected
    end

    it "builds url with parameters" do
      parameters = { "Bar" => "test_value", "Baz" => "another_test_value" }

      url = @connection.build_get_url(@path, parameters)
      expected = "https://testapi.internet.bs/foo/do_something?Bar=test_value&Baz=another_test_value&ResponseFormat=JSON&ApiKey=#{@connection.api_key}&Password=#{@connection.password}"
      url.should == expected
    end
  end

  describe "#build_post_url" do
    it "builds a simple url" do
      url = @connection.build_post_url(@path)
      expected = "https://testapi.internet.bs/foo/do_something?ResponseFormat=JSON&ApiKey=#{@connection.api_key}&Password=#{@connection.password}"
      url.should == expected
    end
  end

end
