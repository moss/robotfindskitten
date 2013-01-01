require 'spec_helper'
require 'quitter'

describe Quitter do
  context "until you quit" do
    it { should be_running }
  end

  context "after you quit" do
    before { subject.quit }
    it { should_not be_running }
  end
end