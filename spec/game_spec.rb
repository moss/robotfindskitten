require 'spec_helper'
require 'windly'
require 'game'

describe Game do
  let (:windly) { FakeWindowManager.new }
  subject { Game.new(windly) }
  context "with a robot on square 6, 14" do
    before { subject.place_robot_at 6, 14 }

    context "when the game is started" do
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
        it_behaves_like "robot moved", 6, 13
      end

      context "when you move right" do
        before { subject.move_right }
        it_behaves_like "robot moved", 6, 15
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

    context "with a non-kitten item (NKI) on square 7, 15" do
      before do
        subject.place_non_kitten_item Position.new(7, 15), NonKittenItem.new('{', "A longbow.")
        subject.start
      end

      it("shows the non-kitten item (NKI)") { windly.char_at(7, 15).should == '{' }
    end
  end
end
