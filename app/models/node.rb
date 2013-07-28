class Node
  attr_reader :steps
  attr_writer :step_source
  attr_accessor :plan
  def initialize( )
    @plan = nil
    @steps = []
  end
end
