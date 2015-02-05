# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "rack-with_sequel"
  spec.version       = "0.0.1"
  spec.authors       = ["Vladimir Kochnev"]
  spec.email         = ["hashtable@yandex.ru"]
  spec.summary       = %q{Explicitely acquires a Sequel connection from the pool per request}
  spec.description   = %q{Rack middleware that explicitely acquires a Sequel connection from the pool per request}
  spec.homepage      = "https://github.com/marshall-lee/rack-with_sequel"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "sequel", ">= 2.5.0"
end
