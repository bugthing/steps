class Plan
  attr_reader :nodes, :title
  attr_writer :node_source
  def initialize
    @nodes = []
  end
  def add_node( node )
    @nodes << node
  end
  def new_node(*args)
    node_source.call(*args).tap do |n|
      n.plan = self
      self.add_node(n)
    end
  end

  private

  def node_source
    @node_source ||= Node.public_method(:new)
  end
end
