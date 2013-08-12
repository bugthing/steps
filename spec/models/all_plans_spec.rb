require_relative '../spec_helper'
describe AllPlans do
  subject { described_class }
  describe '#plans' do
    it "gets a list of plans with correctly set callbacks" do
      subject.plans.should_not be_empty
      subject.plans.first.nodes.should_not be_empty
    end
  end
  describe '#new_plan' do
    let(:plan_args) { {name: 'New Plan'} }
    it "creates a new plan with name and is saved" do
      new_plan = subject.new_plan( plan_args )
      new_plan.name.should == 'New Plan'
      new_plan.id.should be_an Integer
    end
  end
end
