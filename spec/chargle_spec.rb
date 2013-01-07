require 'spec_helper'
require 'chargle'

describe Chargle do
  let(:events) { [] }
  subject(:chargle) { Chargle.new }

  context "with no actions defined" do
    it "quietly ignores any key press events sent to it" do
      chargle.pressed 'q'
    end
  end

  context "when you register an action" do
    before do
      chargle.on_press('q') { events << 'q pressed' }
    end

    it "does nothing until a key is pressed" do
      events.should be_empty
    end

    it "should do the action when the key is pressed" do
      chargle.pressed 'q'
      events.should == ['q pressed']
    end

    it "should ignore other keys" do
      chargle.pressed 'r'
      events.should be_empty
    end

    it "should let you redefine an action" do
      chargle.on_press('q') { events << 'fancy!' }
      chargle.pressed 'q'
      events.should == ['fancy!']
    end

    it "should allow triggering of events by character code instead of string" do
      chargle.pressed ?q.ord
      events.should == ['q pressed']
    end
  end

  context "when you register an action by character code" do
    before do
      chargle.on_press(?q.ord) { events << 'q pressed' }
    end

    it "should allow triggering by string" do
      chargle.pressed 'q'
      events.should == ['q pressed']
    end

    it "should allow triggering by character code" do
      chargle.pressed ?q.ord
      events.should == ['q pressed']
    end
  end

  context "when you register an action for multiple characters" do
    before do
      chargle.on_press('a', 'b', 'c') { events << 'key pressed' }
    end

    it "should be triggered by any of them" do
      chargle.pressed 'b'
      chargle.pressed 'c'
      events.should == ['key pressed', 'key pressed']
    end
  end

  context "when you register an action that accepts parameters" do
    before do
      chargle.on_press('a', 'b', 'c') {|key| events << "#{key} pressed" }
    end

    it "should pass the key pressed as a parameter to the action" do
      chargle.pressed 'b'
      chargle.pressed 'a'
      chargle.pressed 'c'

      events.should == ['b pressed', 'a pressed', 'c pressed']
    end

    it "should parse key codes into characters when passing parameters" do
      chargle.pressed ?a.ord
      chargle.pressed ?c.ord

      events.should == ['a pressed', 'c pressed']
    end
  end
end
