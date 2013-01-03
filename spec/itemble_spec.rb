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

    context "when you pick just one item" do
      subject { itemble.pick(1) }
      it { should have(1).item }
    end

    context "when you run it several times in a row" do
      it "should not always return things in the same order" do
        results = []
        100.times { results << itemble.pick(1) }
        results.sort.uniq.should have(2).different_results
      end
    end
  end
end