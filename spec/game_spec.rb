require 'spec_helper'
require 'windly'
require 'game'

describe Game do
  let (:windly) { FakeWindowManager.new }
  subject { Game.new(windly) }
  before { subject.place_robot_at 6, 14 }

  context "when the game is started with the robot on square 2, 14" do
    before { subject.start }

    it "shows a welcome message" do
      windly.row(24).should start_with("Find kitten!")
    end

    it "shows the robot as #" do
      windly.char_at(6, 14).should == '#'
    end

    shared_examples "robot moved" do |row, column|
      it("shows the robot in its new position") { windly.char_at(row, column).should == '#' }
      it("shows a blank space where the robot was before") { windly.char_at(6, 14).should == ' ' }
    end

    context "when you move left" do
      before { subject.move_left }
      it_should_behave_like "robot moved", 6, 13
    end

    context "when you move right" do
      before { subject.move_right }
      it_should_behave_like "robot moved", 6, 15
    end

    context "when you move up" do
      before { subject.move_up }
      it_should_behave_like "robot moved", 5, 14
    end

    context "when you move down" do
      before { subject.move_down }
      it_should_behave_like "robot moved", 7, 14
    end
  end
end
