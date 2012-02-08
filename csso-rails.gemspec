# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "csso/version"

Gem::Specification.new do |s|
  s.name        = "csso-rails"
  s.version     = Csso::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Vasily Fedoseyev"]
  s.email       = [""]
  s.homepage    = "https://github.com/Vasfed/csso-rails"
  s.summary     = %q{CSS Stylesheet optimizer/compressor for Rails}
  s.description = %q{Invoke the CSSO from Ruby}

  s.rubyforge_project = "csso-rails"

  s.files         = `git ls-files`.split("\n")
  js_root = 'lib/csso/js'
  Dir.chdir(js_root) do
    s.files += `git ls-files`.split("\n").map {|f| File.join(js_root,f)}
  end
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "therubyracer", "~> 0.9.9"
  s.add_dependency "commonjs", "~> 0.2.0"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.0"
end
