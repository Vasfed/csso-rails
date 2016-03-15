# to test against all, run: appraisal rake spec

# sprockets-1 is unsupported

appraise "sprockets-2" do
  gem "sprockets", "~>2.0"
end

appraise "sprockets-3" do
  gem "sprockets", "~>3.0"
end

appraise "sprockets-4" do
  gem "sprockets", "~>4.0.0.beta2"
  gem 'sass', '>=3.3'
end

appraise "rails-4" do
  gem "rails", '4.2.5.1'
end


appraise "therubyracer" do
  #TODO: currently rubyracer segfaults on my machine, fix that and start testing
  # gem "therubyracer"
end
