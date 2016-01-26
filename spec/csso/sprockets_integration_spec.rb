#encoding: utf-8

require 'minitest/autorun'
require 'fileutils'
require 'csso'

Encoding.default_external = Encoding::UTF_8

describe Csso do

  subject { Csso }
  let(:sprockets_env){
    e = Sprockets::Environment.new(File.expand_path('../', File.dirname(__FILE__)))
    e.append_path 'fixtures'
    e.config = e.config.merge(gzip_enabled: false).freeze if e.respond_to? :config
    e
  }
  let(:result_dir){
    d = File.expand_path('../fixtures/res', File.dirname(__FILE__))
    FileUtils.mkdir_p(d)
    d
  }
  let(:manifest_file){
    File.expand_path('manifest.json', result_dir)
  }
  let(:manifest){
    Sprockets::Manifest.new(sprockets_env, result_dir, manifest_file)
  }

  it "installs" do
    begin
      require 'sprockets'
    rescue LoadError
      skip "Skipping sprockets integration, as there's no sprockets in this env"
    end

    subject.install(sprockets_env)
    sprockets_env.css_compressor.must_equal Csso::Compressor
    manifest.environment.must_equal(sprockets_env)
    manifest.clobber
    res = manifest.compile('test.css')
    res.size.must_equal 1
    [File.expand_path('../../fixtures/test.css', __FILE__), 'test.css'].must_include res.first
    File.read(manifest_file).wont_equal '{}'
    sprockets_env['test.css'].source.must_equal '.class{color:red}'
    manifest.clobber
  end



end
