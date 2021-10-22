# frozen_string_literal: true

require 'json'
require 'pry'

Dir["#{File.dirname(__dir__)}/lib/**/*.rb"].sort.each { |file| require file }
