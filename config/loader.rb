require 'json'
require 'pry'

binding.pry

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].sort.each { |file| require file }
