require_relative '../../lib/injected_association'

describe InjectedAssociation do

  before(:all) do
    # create any old class and extend it with the module under test
    Object.const_set('MadeUpClass', Class.new { })
    MadeUpClass.send(:extend, InjectedAssociation)
  end

  describe '::injected_association' do
    let(:ass) { :node }
    subject { 
      MadeUpClass.injected_association( ass )
      MadeUpClass.new 
    }
    it "has a number of instance methods added to it" do
      subject.should respond_to :node_source
      subject.should respond_to :node_fetcher
      subject.should respond_to :nodes
      subject.should respond_to :node_source=
      subject.should respond_to :node_fetcher=
      subject.should respond_to :new_node
      subject.should respond_to :add_node
    end
    describe '#node_fetcher' do
      it "defaults to a lambda that returns an array" do
        subject.node_fetcher.should be_an Proc
        expect(subject.node_fetcher.call).to be_an Array
      end
    end
    describe '#node_source' do
      it "defaults to a lambda that returns an array" do
        subject.node_source.should be_an Proc
        expect(subject.node_source.call).to be_an Hash
      end
    end
    describe '#nodes' do
      it "calls the fetcher and method returns the result" do
        nodes = [1,2,3,'four']
        subject.node_fetcher = lambda { nodes }
        subject.nodes.should == nodes
      end
    end
    describe '#node_fetcher=' do
      let(:fetcher) { lambda{} }
      it "stores its value" do
        subject.node_fetcher = fetcher
        subject.node_fetcher.should == fetcher
      end
    end
    describe '#node_source=' do
      let(:source) { lambda{} }
      it "stores its value" do
        subject.node_source = source
        subject.node_source.should == source
      end
    end
    describe '#add_node' do
      let(:node) { double('Node', save: true ) }
      it "calls saved on the passed in object" do
        subject.add_node( node ).should be_true
      end
    end
    describe '#new_node' do
      let(:node) { double('Node', save: true ) }
      it "calls the source and then adds the node using #add_node" do
        expect(subject).to receive(:node_source).and_return(lambda { |*args| node } )
        expect(subject).to receive(:add_node)
        subject.new_node.should == node
      end
    end
  end

end
