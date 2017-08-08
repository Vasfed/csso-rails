# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "csso/version"

Gem::Specification.new do |s|
  s.name        = "csso-rails"
  s.version     = Csso::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Vasily Fedoseyev"]
  s.email       = ["vasilyfedoseyev@gmail.com"]
  s.homepage    = "https://github.com/Vasfed/csso-rails"
  s.summary     = %q{CSS Stylesheet optimizer/compressor for Rails}
  s.description = %q{Invoke the CSSO from Ruby}
  s.license     = 'MIT'

  s.rubyforge_project = "csso-rails"

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(Regexp.union(
      %r{^\.},
      %r{^spec/},
      %r{^Appraisals},
      %r{^Gemfile},
      %r{^gemfiles/},
      %r{^Rakefile},
    ))
  end
  s.files         += [Csso::CSSO_JS_LIB]

  s.bindir        = 'bin'
  s.executables   = `git ls-files -z -- bin/*`.split("\x0").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'execjs', '>= 1'

  s.add_development_dependency 'bundler', '~> 1.15'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'appraisal'
end
