require_relative '../spec_helper'
describe Step do
  context "new default" do
    subject { described_class.new }
    it "has no node" do
      subject.node.should be_nil
    end
    it "has no tool" do
      subject.tool.should be_nil
    end
    it "can set/get tool" do
      tool = OpenStruct.new
      subject.tool = tool
      subject.tool.should == tool
    end
  end
end
