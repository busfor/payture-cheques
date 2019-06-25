# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payture/cheques/version'

Gem::Specification.new do |spec|
  spec.name          = "payture-cheques"
  spec.version       = Payture::Cheques::VERSION
  spec.authors       = ["Alexander Sviridov"]
  spec.email         = ["alexander.sviridov@gmail.com"]

  spec.summary       = %q{Payture payment system API for sendind cheques separately from payments}
  spec.homepage      = 'https://github.com/busfor/payture-cheques'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '~> 0.9'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
