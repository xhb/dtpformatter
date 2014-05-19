# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dtpformatter/version'

Gem::Specification.new do |spec|
  spec.name          = "dtpformatter"
  spec.version       = Dtpformatter::VERSION
  spec.authors       = ["xhb"]
  spec.email         = ["programstart@163.com"]
  spec.description   = %q{use for recording dtp_workload case performance data}
  spec.summary       = %q{use for recording dtp_workload case performance data}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  
  spec.add_development_dependency "rspec", "~> 2.0"
  spec.add_development_dependency "rspec-core", "!= 2.12.0"

end
