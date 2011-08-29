# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ratonga/version"

Gem::Specification.new do |s|
  s.name        = "ratonga"
  s.version     = Ratonga::VERSION
  s.authors     = ["Chanik Yeon"]
  s.email       = ["chaniks@gmail.com"]
  s.homepage    = "https://github.com/chaniks/ratonga"
  s.summary     = %q{distributed client web service}
  s.description = %q{distributed client web service}

  s.rubyforge_project = "ratonga"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", '~> 2.6'
  # s.add_runtime_dependency "rest-client"
end
