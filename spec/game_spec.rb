require 'spec_helper'
require 'windly'
require 'quitter'
require 'game'

describe Game do
  let(:quitter) { Quitter.new }
  let(:windly) { FakeWindowManager.new }
  subject(:game) { Game.new(windly, quitter) }
  context "with a robot on square 6, 14" do
    before { game.place_robot_at 6, 14 }

    context "when the game is started" do
      before { game.start }

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
        before { game.move_left }
        it_behaves_like "robot moved", 6, 13
      end

      context "when you move right" do
        before { game.move_right }
        it_behaves_like "robot moved", 6, 15
      end

      context "when you move up" do
        before { game.move_up }
        it_should_behave_like "robot moved", 5, 14
      end

      context "when you move down" do
        before { game.move_down }
        it_should_behave_like "robot moved", 7, 14
      end
    end

    context "with a non-kitten item (NKI) on square 7, 15" do
      before do
        game.place_item Position.new(7, 15), NonKittenItem.new('{', "A longbow.")
        game.start
      end

      it("shows the non-kitten item (NKI)") { windly.char_at(7, 15).should == '{' }

      context "when the player walks into the non-kitten item (NKI)" do
        before do
          game.move_right
          game.move_down
        end

        it("still shows the NKI where it was") { windly.char_at(7, 15).should == '{' }
        it("still shows the robot where it was") { windly.char_at(6, 15).should == '#' }
        it("shows the description") { windly.row(0).should start_with("A longbow.") }
        it("doesn't quit the game yet") { quitter.should be_running }
      end
    end

    context "with a kitten on square 5, 13" do
      before do
        game.place_item Position.new(5, 13), Kitten.new('&')
        game.start
      end

      it("shows the kitten") { windly.char_at(5, 13).should == '&' }

      context "when the player walks into the kitten" do
        before do
          game.move_up
          game.move_left
        end

        it("still shows the kitten where it was") { windly.char_at(5, 13).should == '&' }
        it("still shows the robot where it was") { windly.char_at(5, 14).should == '#' }
        it("congratulates you for finding a kitten") { windly.row(0).should start_with("Congratulations! You found kitten!") }
        it("quits the game") { quitter.should_not be_running }
      end
    end
  end
end
