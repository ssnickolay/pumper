# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'bumper/version'

Gem::Specification.new do |s|
  s.name        = 'bumper'
  s.version     = Bumper::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Nikolay Sverchkov']
  s.email       = ['ssnikolay@gmail.com']
  s.homepage    = 'https://github.com/ssnikolay/bumper'
  s.summary     = 'Gem for move another gems to dependent projects'
  s.description = 'Gem for move another gems to dependent projects'

  s.rubyforge_project = 'bumper'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'rspec-its', '~> 1.1'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'activesupport', '~> 4.2'
end