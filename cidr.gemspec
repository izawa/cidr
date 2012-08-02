# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cidr/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["いざわゆきみつ (Yukimitsu Izawa)"]
  gem.email         = ["izawa@izawa.org"]
  gem.description   = %q{IPv4 CIDR  aggregator for IPv4 addresses}
  gem.summary       = %q{IPv4 CIDR  aggregator for IPv4 addresses}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cidr"
  gem.require_paths = ["lib"]
  gem.version       = Cidr::VERSION
end
