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

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.51'
  spec.add_development_dependency 'simplecov', '~> 0.14'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_development_dependency 'webmock', '~> 3.0'
  spec.add_development_dependency 'pp'
end
