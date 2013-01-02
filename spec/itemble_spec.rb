require 'spec_helper'
require 'stringio'
require 'itemble'

describe Itemble do
  context "from a file of two items" do
    let(:input) do
      StringIO.new <<-HERE
        One item.
        Another item.
      HERE
    end
    let(:itemble) { Itemble.new(input) }

    context "when you pick two items" do
      subject { itemble.pick(2) }
      it { should include("One item.") }
      it { should include("Another item.") }
    end
  end
end