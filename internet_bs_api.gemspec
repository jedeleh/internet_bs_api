$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "internet_bs_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "internet_bs_api"
  s.version     = InternetBsApi::VERSION
  s.authors     = ["JD Kaplan"]
  s.email       = ["jaydel@gmail.com"]
  s.homepage    = "https://github.com/jedeleh/internet_bs_api"
  s.summary     = "Wrapper for the Internet.bs reseller API."
  s.description = "A gem that exposes the Internet.bs domain reseller API for use in Ruby applications."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "> 3.0"
end
