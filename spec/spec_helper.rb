# -*- encoding : utf-8 -*-
require 'pry'
require 'rspec'
require 'bumper'

Dir['spec/support/**/*.rb'].each do |file|
  require File.join(File.dirname(__FILE__), '..', file)
end
