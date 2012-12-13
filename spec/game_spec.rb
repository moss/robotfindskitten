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
  end
end
