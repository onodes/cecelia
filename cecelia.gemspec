# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$:.unshift lib unless $:.include?(lib)
require "cecelia/version"

Gem::Specification.new do |s|
  s.name        = "cecelia"
  s.version     = Cecelia::VERSION
  s.authors     = ["Daichi ONODERA"]
  s.email       = ["onodes@onod.es"]
  s.homepage    = "https://github.com/onodes/cecelia"
  s.summary     = %q{cecelia}
  s.description = %q{cecelia}

  s.rubyforge_project = "cecelia"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
