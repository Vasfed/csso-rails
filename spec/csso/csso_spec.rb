# frozen_string_literal: true

require 'minitest/autorun'
require 'csso'

# Encoding.default_external = Encoding::UTF_8

describe Csso do
  subject { Csso }

  it 'dummy test' do
    1.must_equal 1
  end

  it 'should optimize css' do
    subject.optimize("a  {\ncolor: white; }").must_equal 'a{color:#fff}'
  end

  it 'should optimize structure' do
    subject.optimize("a  {\ncolor: white; } a{color: red;}").must_equal 'a{color:red}'
  end

  it 'should optimize structure' do
    skip 'original csso is a bit broken at the moment'
    # FIXME: csso produces "a{color:#fff;color:red}" on this :(
    subject.optimize("a  {\ncolor: white; } a{color: #ff0000;}").must_equal 'a{color:red}'
  end

  it 'should optimize structure in maniac mode' do
    subject.optimize("a  {\ncolor: white; } a{color: #ff0000;}", true).must_equal 'a{color:red}'
  end

  it 'should produce no error on empty input' do
    subject.optimize(nil).must_be_nil
    subject.optimize('').must_equal ''
  end
end
