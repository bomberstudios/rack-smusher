# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'rack/smusher'

Gem::Specification.new do |s|
  s.name        = "rack-smusher"
  s.version     = Rack::Smusher::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ale Muñoz"]
  s.email       = ["bomberstudios@gmail.com"]
  s.homepage    = "http://github.com/bomberstudios/rack-smusher"
  s.summary     = %q{Smush your images}
  s.description = %q{rack-smusher uses the smusher gem to compress your images dinamically}

  s.rubyforge_project = "rack-smusher"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('rack')
  s.add_dependency('smusher')
end
