require 'bundler'
require 'bundler/setup'

require 'rake/testtask'

Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs.push 'spec'
end

$:.push File.expand_path("../lib", __FILE__)
require 'csso/version'

Bundler::GemHelper.install_tasks

task :default => :spec


file 'csso' do
  puts 'Fetching csso repo...'
  `git clone --single-branch --depth 1 --no-hardlinks git://github.com/css/csso`
  Dir.chdir('csso'){
    puts 'Now making web-version, just in case.'
    `rm web/csso.web.js; make web`
  }
end

task :update_csso => :csso do
  #??
  Dir.chdir('csso'){
    puts 'Updating csso...'
    `git pull --rebase`
    `rm web/csso.web.js; make web`
  }
end

directory 'vendor/csso'
lib_template = 'lib/csso/csso.js.erb'
file Csso::CSSO_JS_LIB => [lib_template, 'csso', 'vendor/csso', 'csso/.git/HEAD', 'csso/.git/refs/heads/master'] do
  puts "Generating #{Csso::CSSO_JS_LIB}"
  `erb #{lib_template} > #{Csso::CSSO_JS_LIB}`
end

task :generate_files => [Csso::CSSO_JS_LIB]

task :rm_generated do
  puts "Removing #{Csso::CSSO_JS_LIB}"
  `rm #{Csso::CSSO_JS_LIB}`
end

task :regenerate => [:rm_generated, :generate_files]

task :build => :generate_files