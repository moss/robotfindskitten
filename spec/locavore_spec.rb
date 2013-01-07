require 'spec_helper'
require 'locavore'

shared_examples "a viable hash key or set member" do |equal_examples, unequal_examples|
  equal_examples.each do |equal_example|
    it { should eql(equal_example) }

    it "should have the same hash code as #{equal_example}" do
      subject.hash.should == equal_example.hash
    end
  end

  unequal_examples.each do |unequal_example|
    it { should_not eql(unequal_example) }

    it "should not have the same hash code as #{unequal_example}" do
      subject.hash.should_not == unequal_example.hash
    end
  end
end

describe "Position for row 3, column 4" do
  subject(:position) { Position.new(3, 4) }

  it "should expose row and column" do
    position.row.should == 3
    position.column.should == 4
  end

  context "equality" do
    it { should == Position.new(3, 4) }
    it { should_not == Position.new(2, 4) }
    it { should_not == Position.new(3, 5) }
  end

  it_should_behave_like "a viable hash key or set member", [Position.new(3, 4)], [Position.new(2, 4), Position.new(3, 5)]

  context "moving left" do
    it { position.left.should == Position.new(3, 3) }
  end

  context "moving right" do
    it { position.right.should == Position.new(3, 5) }
  end

  context "moving up" do
    it { position.up.should == Position.new(2, 4) }
  end

  context "moving down" do
    it { position.down.should == Position.new(4, 4) }
  end
end

