require 'spec_helper'
require 'windly'
require 'game'

describe Game do
  let (:windly) { FakeWindowManager.new }
  subject { Game.new(windly) }

  context "when the game is started" do
    before { subject.start }

    it "shows a welcome message" do
      windly.row(24).should start_with("Find kitten!")
    end
  end
end
