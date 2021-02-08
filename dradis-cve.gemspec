$:.push File.expand_path('../lib', __FILE__)
require 'dradis/plugins/cve/version'
version = Dradis::Plugins::CVE::VERSION::STRING

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.platform    = Gem::Platform::RUBY
  spec.name        = 'dradis-cve'
  spec.version     = version
  spec.summary     = 'CVE add-on for the Dradis Framework.'
  spec.description = 'Query the remote CVE database and import its entries.'

  spec.license     = 'GPL-2'

  spec.authors     = ['Dradis Team']
  spec.email       = ['>moc.stoorytiruces@liame<'.reverse]
  spec.homepage    = 'https://dradisframework.com/pro/add-ons/cve.html'

  spec.files       = `git ls-files`.split($\)
  spec.executables = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files  = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_dependency 'dradis-plugins', '~> 3.2'
end
