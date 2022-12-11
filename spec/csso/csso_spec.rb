# frozen_string_literal: true

require 'minitest/autorun'
require 'csso'

# Encoding.default_external = Encoding::UTF_8

describe Csso do
  subject { Csso }

  it 'dummy test' do
    expect(1).must_equal 1
  end

  it 'should optimize css' do
    expect(subject.optimize("a  {\ncolor: white; }")).must_equal 'a{color:#fff}'
  end

  it 'should optimize structure' do
    expect(subject.optimize("a  {\ncolor: white; } a{color: red;}")).must_equal 'a{color:red}'
  end

  it 'should optimize structure' do
    expect(subject.optimize("a  {\ncolor: white; } a{color: #ff0000;}")).must_equal 'a{color:red}'
  end

  it 'should optimize structure in maniac mode' do
    expect(subject.optimize("a  {\ncolor: white; } a{color: #ff0000;}", true)).must_equal 'a{color:red}'
  end

  it 'should produce no error on empty input' do
    expect(subject.optimize(nil)).must_be_nil
    expect(subject.optimize('')).must_equal ''
  end
end
