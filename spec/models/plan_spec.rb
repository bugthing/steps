require_relative '../spec_helper'
require_relative '../../app/models/plan'
require 'ostruct'
describe Plan do

  context "new default" do
    subject { described_class.new }
    it "has no nodes" do
      subject.nodes.should be_empty
    end
    it "has no title" do
      subject.title.should be_nil
    end
    describe "#add_node" do
      it "adds the node to the plan" do
        node = Object.new
        subject.add_node(node)
        subject.nodes.should include(node)
      end
    end
    describe "#new_node" do
      let(:new_node) { OpenStruct.new }
      let(:node_source) { double('NodeSource', call: new_node) }
      before { subject.node_source = node_source }
      it "adds a new node to its list" do
        subject.new_node
        subject.nodes.should include(new_node)
      end
      it "returns a new node" do
        subject.new_node.should equal new_node
      end
      it "sets the node's plan reference to itself" do
        subject.new_node.plan.should equal subject
      end
      context "with some args" do
        let(:node_args) { {foo: 123, bar: 'abc'} }
        it "passes args on to node source" do
          expect(node_source).to receive(:call).with(node_args)
          subject.new_node( node_args ) 
        end
      end
    end
  end
end
