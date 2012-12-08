require 'spec_helper'
require 'windly'

describe WindowManager do
  let (:window) { gimme }
  subject { WindowManager.new window }

  context "when you print to a certain row or column" do
    before { subject.print 4, 5, 'w' }
    it "should write to the window" do
      verify(window).printstring 4, 5, 'w', $normalcolor
    end
  end

  context "when the user has typed a character" do
    before do
      give(window).getchar { 'w' }
    end

    it "should tell you that character when asked" do
      subject.getchar.should == 'w'
    end
  end
end
