require_relative '../spec_helper'
require_relative '../../app/models/step'
describe Step do
  context "new default" do
    subject { described_class.new }
    it "has no node" do
      subject.node.should be_nil
    end
    it "has no tool" do
      subject.tool.should be_nil
    end
  end
end
