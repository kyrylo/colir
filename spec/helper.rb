require 'bacon'
require 'pry'

require_relative '../lib/colir'

puts "Ruby: #{ RUBY_VERSION }; Colir version: #{ Colir::VERSION }"

def kind_of(klass)
  lambda { |obj| obj.kind_of?(klass) }
end
