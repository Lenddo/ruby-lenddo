# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lenddo/version'

Gem::Specification.new do |spec|
  spec.name          = "lenddo"
  spec.version       = Lenddo.version
  spec.authors       = ["arjay salvadora"]
  spec.email         = ["arjay@lenddo.com"]

  spec.summary       = %q{Lenddo's REST based services}
  spec.homepage      = "https://www.lenddo.com"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "curb", "~> 0.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
