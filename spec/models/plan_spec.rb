require_relative '../spec_helper'
require 'ostruct'
describe Plan do
  subject { described_class.new }
  context "new default" do
    it "has no nodes" do
      subject.nodes.should be_empty
    end
    it "has no name" do
      subject.name.should be_nil
    end
    it "can set/get name" do
      subject.name = "Supa plan"
      subject.name.should == "Supa plan"
    end
    context "with constructor args" do
      let(:name) { 'Plan A' }
      let(:args) { { name: name } }
      specify do
        plan = described_class.new(args) 
        plan.name.should == name
      end
    end

    describe "#add_node" do
      it "set the plan and then calls save on the passed in node" do
        node = double('Node')
        expect( node ).to receive(:plan=)
        expect( node ).to receive(:save)
        subject.add_node(node)
      end
    end

    describe "#new_node" do
      let(:node) { OpenStruct.new }
      let(:node_source) { double('NodeSource', call: node) }
      before { subject.node_source = node_source }
      it "uses the node_source to get a node and calls #save on it" do
        expect( node_source ).to receive(:call)
        expect( node ).to receive(:save)
        subject.new_node.should == node
      end
      it "sets the node's plan reference to itself" do
        subject.new_node.plan.should equal subject
      end
      context "with some args" do
        let(:node_args) { {foo: 123, bar: 'abc'} }
        it "passes args on to node source" do
          node_source.should_receive(:call).with(node_args)
          subject.new_node( node_args ) 
        end
      end
    end

  end
  context "full integration" do
    it "works" do
      tool = Tool.create(name:'Tool A')

      plan = Plan.create(name:'Plan A')
      plan.node_fetcher = lambda { Node.where(plan_id: plan.id) }
      plan.node_source = lambda { |args| Node.new( {plan_id: plan.id}.merge(args)) }

      node = plan.new_node(name:'Node A')
      node.step_fetcher = lambda { Step.where(node_id: node.id) }
      node.step_source = lambda { |args| Step.new( {node_id: node.id}.merge(args)) }

      step = node.new_step(tool: tool, node: node)
      #step = Step.create(tool:tool, node:node)

      plan.should_not be_nil
      puts "*****> #{ plan.nodes.count } -- #{ node.steps.count }"

      @plans = [plan]
    end
  end
end
