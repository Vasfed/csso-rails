# frozen_string_literal: true

source 'https://rubygems.org'

gem 'irb'

gem 'bundler', '~> 1.16' # rails 3 requirement

unless defined?(Appraisal)
  group :rubocop do
    gem 'rubocop'
    gem 'rubocop-minitest'
    gem 'rubocop-performance'
    gem 'rubocop-rake'
  end
end

gemspec
