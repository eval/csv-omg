require 'rubygems'
require 'test/spec'
require 'rr'

require File.join(File.dirname(__FILE__), '..', 'lib', 'csv-omg')

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end
