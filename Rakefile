# frozen_string_literal: true

require 'bundler'
require 'bundler/setup'

require 'rake/testtask'

Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs.push 'spec'
end

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'csso/version'

Bundler::GemHelper.install_tasks

task default: :spec
task test: :spec

file 'csso' do
  puts 'Fetching csso repo...'
  `git clone --single-branch --depth 1 --no-hardlinks git://github.com/css/csso`
  Dir.chdir('csso')  do
    puts 'Now making web-version, just in case.'
    `npm install && npm run build`
  end
end

desc 'updates csso repo'
task update_csso_repo: :csso do
  # ??
  Dir.chdir('csso') do
    puts 'Updating csso...'
    `git pull --rebase`
    `yarn install && npm run build`
  end
end

directory 'vendor/csso'
lib_template = 'lib/csso/csso.js.erb'
file Csso::CSSO_JS_LIB => [
  lib_template,
  'csso',
  'vendor/csso',
  'csso/.git/HEAD',
  'csso/.git/refs/heads/master'
] do
  puts "Generating #{Csso::CSSO_JS_LIB}"
  `erb #{lib_template} > #{Csso::CSSO_JS_LIB}`
end

desc 'Generate bundled csso from repo'
task generate_files: [:csso, Csso::CSSO_JS_LIB]

desc 'Clean generated files'
task :rm_generated do
  puts "Removing #{Csso::CSSO_JS_LIB}"
  `rm #{Csso::CSSO_JS_LIB}`
end

task regenerate: %i[rm_generated generate_files]

desc 'Update CSSO'
task update_csso: %i[rm_generated update_csso_repo generate_files]

task build: :generate_files
