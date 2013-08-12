class Plan < ActiveRecord::Base
  validates :name, presence: true

  attr_writer :node_source
  attr_writer :node_fetcher

  def nodes
    node_fetcher.call
  end

  def add_node( node )
    node.plan = self
    node.save
  end

  def new_node(*args)
    node_source.call(*args).tap do |n|
      self.add_node(n)
    end
  end

  private

  def node_fetcher
    #@node_fetcher ||= lambda { Node.where( :plan_id => self.id ) }
    @node_fetcher ||= lambda { @nodes ||= [] }
  end
  def node_source
    #@node_source ||= Node.public_method(:new)
    @node_source ||= lambda { |*args| 
      Hash.new(*args) 
      h.define_method(:save) { @nodes << h }
      h
    }
  end
end
