require 'spec_helper'
require 'chargle'

describe Chargle do
  let(:events) { [] }
  subject { Chargle.new }

  context "with no actions defined" do
    it "quietly ignores any key press events sent to it" do
      subject.pressed 'q'
    end
  end

  context "when you register an action" do
    before do
      subject.on_press('q') { events << 'q pressed' }
    end

    it "does nothing until a key is pressed" do
      events.should be_empty
    end

    it "should do the action when the key is pressed" do
      subject.pressed 'q'
      events.should == ['q pressed']
    end

    it "should ignore other keys" do
      subject.pressed 'r'
      events.should be_empty
    end

    it "should let you redefine an action" do
      subject.on_press('q') { events << 'fancy!' }
      subject.pressed 'q'
      events.should == ['fancy!']
    end

    it "should allow triggering of events by character code instead of string" do
      subject.pressed ?q.ord
      events.should == ['q pressed']
    end
  end

  context "when you register an action by character code" do
    before do
      subject.on_press(?q.ord) { events << 'q pressed' }
    end

    it "should allow triggering by string" do
      subject.pressed 'q'
      events.should == ['q pressed']
    end

    it "should allow triggering by character code" do
      subject.pressed ?q.ord
      events.should == ['q pressed']
    end
  end

  context "when you register an action for multiple characters" do
    before do
      subject.on_press('a', 'b', 'c') { events << 'key pressed' }
    end

    it "should be triggered by any of them" do
      subject.pressed 'b'
      subject.pressed 'c'
      events.should == ['key pressed', 'key pressed']
    end
  end

  context "when you register an action that accepts parameters" do
    before do
      subject.on_press('a', 'b', 'c') {|key| events << "#{key} pressed" }
    end

    it "should pass the key pressed as a parameter to the action" do
      subject.pressed 'b'
      subject.pressed 'a'
      subject.pressed 'c'

      events.should == ['b pressed', 'a pressed', 'c pressed']
    end

    it "should parse key codes into characters when passing parameters" do
      subject.pressed ?a.ord
      subject.pressed ?c.ord

      events.should == ['a pressed', 'c pressed']
    end
  end
end
