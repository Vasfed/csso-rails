require 'spec_helper'

describe Csso do

  it "should optimize css" do
    subject.optimize("a  {\ncolor: white; }").should == "a{color:#fff}"
  end

  it "should optimize structure" do
    subject.optimize("a  {\ncolor: white; } a{color: red;}").should == "a{color:red}"
  end

  it "should optimize structure" do
    pending "original csso is a bit broken at the moment"
    # FIXME: csso produces "a{color:#fff;color:red}" on this :(
    subject.optimize("a  {\ncolor: white; } a{color: #ff0000;}").should == "a{color:red}"
  end

  it "should optimize structure in maniac mode" do
    subject.optimize("a  {\ncolor: white; } a{color: #ff0000;}", true).should == "a{color:red}"
  end

  it 'should produce no error on empty input' do
    subject.optimize(nil).should == nil
    subject.optimize("").should == ""
  end

end
