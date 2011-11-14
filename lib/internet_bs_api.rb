require 'internet_bs_api/domain'
require 'internet_bs_api/private_who_is'
require 'internet_bs_api/registrar_lock'
require 'internet_bs_api/transfer'
require 'internet_bs_api/dns_record'
require 'internet_bs_api/host'
require 'internet_bs_api/account'
require 'internet_bs_api/url_forward'
require 'internet_bs_api/email_forward'

SETTINGS = YAML.load_file(File.join(Rails.root, "config", "internet_bs_api.yaml"))

module InternetBsApi
  include Account
  include Domain
end
