require 'spec_helper'
require 'locavore'
require 'windly'

shared_examples "a windly window manager" do
  context "when you print to a certain row or column" do
    before { subject.print Position.new(4, 5), 'w' }
    it "should write to the window" do
      check_printed(4, 5, 'w')
    end
  end

  context "when the user has typed a character" do
    before do
      given_user_typed('w')
    end

    it "should tell you that character when asked" do
      subject.getchar.should == 'w'
    end
  end

  def check_printed(row, column, expected_character)
    raise "Windly window manager specs should define check_printed(row, column, expected_character)"
  end

  def given_user_typed(key)
    raise "Windly window manager specs should define given_user_typed(key)"
  end
end

describe WindowManager do
  let (:window) { gimme }
  subject { WindowManager.new window }

  it_should_behave_like "a windly window manager" do
    def check_printed(row, column, expected_character)
      verify(window).printstring row, column, expected_character, $normalcolor
    end

    def given_user_typed(key)
      give(window).getchar { key }
    end
  end
end

describe FakeWindowManager do
  subject { FakeWindowManager.new }

  it_should_behave_like "a windly window manager" do
    def check_printed(row, column, expected_character)
      subject.char_at(row, column).should == expected_character
    end

    def given_user_typed(key)
      subject.type key
    end
  end

  it "should blow up if you ask it for input without setting any up" do
    proc { subject.getchar }.should raise_exception
  end

  context "when you write a multi-character string over existing output" do
    before do
      subject.print Position.new(4, 5), '1'
      subject.print Position.new(4, 7), '2'
      subject.print Position.new(4, 4), 'abc'
    end

    it "should write all of the characters into the right positions" do
      subject.char_at(4, 4).should == 'a'
      subject.char_at(4, 5).should == 'b'
      subject.char_at(4, 6).should == 'c'
    end

    it "should leave characters unchanged if it did not overwrite them" do
      subject.char_at(4, 7).should == '2'
    end

    it "should not bleed into other rows" do
      subject.char_at(5, 4).should == ' '
    end
  end
end