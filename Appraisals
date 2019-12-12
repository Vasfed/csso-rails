# frozen_string_literal: true

# to test against all, run: appraisal rake spec

# sprockets-1 is unsupported

appraise 'sprockets-2' do
  gem 'sprockets', '~>2.0'
end

appraise 'sprockets-3' do
  gem 'sprockets', '~>3.0'
end

appraise 'sprockets-4' do
  gem 'sprockets', '~>4.0'
  gem 'sass-rails', '>=6.0'
end

appraise 'rails-3' do
  gem 'rails', '~>3.2'
end

appraise 'rails-4' do
  gem 'rails', '~>4.2.0'
end

appraise 'rails-5' do
  gem 'rails', '~>5.2'
end

appraise 'rails-6' do
  gem 'rails', '~>6.0.1'
end

# appraise "therubyracer" do
# TODO: currently rubyracer segfaults on my machine, fix that and start testing
# gem "therubyracer"
# end
