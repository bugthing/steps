require_relative '../spec_helper'
describe Node do

  context "new default" do
    subject { described_class.new }
    it "starts with blank attributes" do
      subject.steps.should be_empty
      subject.name.should be_nil
      subject.plan.should be_nil
    end

    it "supports writing and reading of attibutes" do
      subject.name = "nodey"
      subject.name.should == "nodey"
    end

    it "supports reading and writing a plan reference" do
      plan = Plan.new # NOTE - tight coupling here!
      subject.plan = plan
      subject.plan.should equal plan
    end

    describe "#add_step" do
      it "set the plan and then calls save on the passed in step" do
        step = double('Step')
        expect( step ).to receive(:save)
        subject.add_step(step)
      end
    end

    describe "#new_step" do
      let(:step) { OpenStruct.new }
      let(:step_source) { double('StepSource', call: step) }
      before { subject.step_source = step_source }
      it "uses the step_source to get a step and calls #save on it" do
        expect( step_source ).to receive(:call)
        expect( step ).to receive(:save)
        subject.new_step.should == step 
      end
      context "with some args" do
        let(:step_args) { {foo: 123, bar: 'abc'} }
        it "passes args on to step source" do
          step_source.should_receive(:call).with(step_args)
          subject.new_step( step_args ) 
        end
      end
    end

  end
end
