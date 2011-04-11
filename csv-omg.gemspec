# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "csv-omg/version"

Gem::Specification.new do |s|
  s.name        = "csv-omg"
  s.version     = CsvOmg::Version
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Gert Goet"]
  s.email       = ["gert@thinkcreate.nl"]
  s.homepage    = "http://github.com/eval/csv-omg"
  s.summary     = %q{Easily map CSV to objects}
  s.description = <<desc
CsvOmg easily lets you map CSV to objects. Inspired by happymapper.
desc

  s.rubyforge_project = "csv-omg"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('fastercsv', '~>1.5.4')

  s.add_development_dependency('test-spec', '~>0.10.0')
  s.add_development_dependency('rr', '~>1.0.2')
  s.add_development_dependency('activerecord', '~>3.0.6')
  s.add_development_dependency('sqlite3', '~>1.3.3')
end
