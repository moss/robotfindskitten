require 'spec_helper'
require 'windly'
require 'viewup'

class FakeCell
  attr_reader :appearance

  def initialize appearance
    @appearance = appearance
  end
end

describe Viewup do
  let (:windly) { FakeWindowManager.new }
  let (:mappic) { gimme }
  subject { Viewup.new(mappic, windly) }

  context "rendering a map" do
    before do
      give(mappic).cell(4, 5) { FakeCell.new('@') }
      subject.update
    end

    it "should draw the thing from the map on the screen" do
      windly.char_at(4, 5).should == '@'
    end

    context "when something has moved" do
      before do
        give(mappic).cell(4, 5) { nil }
        give(mappic).cell(5, 6) { FakeCell.new('@') }
        subject.update
      end

      it "should draw the thing in the new location" do
        windly.char_at(5, 6).should == '@'
      end

      it "should clear the thing from the old location" do
        windly.char_at(4, 5).should == ' '
      end
    end
  end
end