# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'csso/version'

Gem::Specification.new do |s|
  s.name        = 'csso-rails'
  s.version     = Csso::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Vasily Fedoseyev']
  s.email       = ['vasilyfedoseyev@gmail.com']
  s.homepage    = 'https://github.com/Vasfed/csso-rails'
  s.summary     = 'CSS Stylesheet optimizer/compressor for Rails'
  s.description = 'Invoke the CSSO from Ruby'
  s.license     = 'MIT'

  s.rubyforge_project = 'csso-rails'

  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(Regexp.union(
              /^\./,
              %r{^spec/},
              /^Appraisals/,
              /^Gemfile/,
              %r{^gemfiles/},
              /^Rakefile/
            ))
  end
  s.files += [Csso::CSSO_JS_LIB]

  s.bindir        = 'bin'
  s.executables   = `git ls-files -z -- bin/*`.split("\x0").map do |f|
    File.basename(f)
  end
  s.require_paths = ['lib']

  s.add_dependency 'execjs', '>= 1'

  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'bundler', '~> 1.15'
  s.add_development_dependency 'minitest', '>= 4.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-performance'
end
