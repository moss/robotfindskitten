require 'spec_helper'
require 'locavore'

describe "Position for row 3, column 4" do
  subject { Position.new(3, 4) }

  it "should expose row and column" do
    subject.row.should == 3
    subject.column.should == 4
  end

  context "equality" do
    it { should == Position.new(3, 4) }
    it { should_not == Position.new(2, 4) }
    it { should_not == Position.new(3, 5) }
  end

  context "moving left" do
    it { subject.left.should == Position.new(3, 3) }
  end

  context "moving right" do
    it { subject.right.should == Position.new(3, 5) }
  end

  context "moving up" do
    it { subject.up.should == Position.new(2, 4) }
  end

  context "moving down" do
    it { subject.down.should == Position.new(4, 4) }
  end
end

