require_relative '../spec_helper'
require_relative '../../app/models/node'
describe Node do

  context "new default" do
    subject { described_class.new }
    it "has no steps" do
      subject.steps.should be_empty
    end
    it "has no plan" do
      subject.plan.should be_nil
    end
    it "supports reading and writing a plan reference" do
      plan = Object.new
      subject.plan = plan
      subject.plan.should equal plan
    end
  end

end
