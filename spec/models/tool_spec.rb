require_relative '../spec_helper'
describe Tool do
  context "new default" do
    subject { described_class.new }
    it "has no name" do
      subject.name.should be_nil
    end
    it "has no class_name" do
      subject.class_name.should be_nil
    end
    it "can set/get name and class_name" do
      subject.class_name = 'MyTools::ToolA'
      subject.name = 'Tool A'
      subject.class_name.should == 'MyTools::ToolA'
      subject.name.should == 'Tool A'
    end
  end
  describe '#tool_class' do
    it "can find tool class from class_name" do
      subject.class_name = 'String'
      subject.tool_class.should == String
    end
    it "throws error if not class can be found" do
      subject.class_name = 'Stringy'
      expect { subject.tool_class }.to raise_error('Tool class_name (Stringy) could be referenced')
    end
  end
end
