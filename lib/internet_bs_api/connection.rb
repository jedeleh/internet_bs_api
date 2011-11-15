require 'httparty'

class Connection
  attr_accessor :password, :api_key, :base_url
  def initialize
    @response_format = SETTINGS["internet_bs_api"]["response_format"]
    @api_key = SETTINGS["internet_bs_api"]["api_key"]
    @password = SETTINGS["internet_bs_api"]["password"]
    @base_url = SETTINGS["internet_bs_api"]["url_base"]
    if SETTINGS["internet_bs_api"]["test_mode"] == true
      @base_url = SETTINGS["internet_bs_api"]["test_url_base"]
      @api_key = SETTINGS["internet_bs_api"]["test_api_key"]
      @password = SETTINGS["internet_bs_api"]["test_password"]
    end
  end

  def post(path, options)
    #url = build_post_url(path)
    url = build_get_url(path, options)
    ResponseValues.new(HTTParty.post(url, options))
  end

  def get(path, options)
    url = build_get_url(path)
    ResponseValues.new(HTTParty.get(url))
  end

  def build_get_url(path, options)
    options.merge!({ "ResponseFormat" => @response_format, "ApiKey" => @api_key, "Password" => @password })
    url = "#{@base_url}#{path}?"

    parameters = []
    options.each_pair do |name, value|
      parameters << "#{name}=#{value}"
    end
    url += parameters.join("&")
  end

  def build_post_url(path)
    url = "#{@base_url}#{path}?ResponseFormat=#{@response_format}&ApiKey=#{@api_key}&Password=#{@password}"
  end
end

class ResponseValues

  def initialize(response)
    @values = ingest_response response
    @code = response.code
  end

  def [](key)
    @values[key]
  end

  def keys()
    return @values.keys
  end

  def ingest_response(response)
    values = {}
    response.body.split("\n").each do |pair|
      tuple = pair.split("=")
      values[tuple[0]] = tuple[1]
    end
    values
  end
end
