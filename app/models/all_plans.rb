=begin

Top level model class to get a handle on plan/nodes/steps
Main job so far: Apply Callback to find plans in ActiveRecord.

=end

class AllPlans

  def self.new_plan(*args)
    plan = Plan.new(*args)
    plan.save
    apply_ar_callbacks(plan)
  end

  def self.plans
    Plan.all.map { |plan| apply_ar_callbacks(plan) }
  end

  private

  def self.apply_ar_callbacks(plan)
    plan.node_fetcher = lambda {
      Node.where(plan_id: plan.id).map do |node|
        node.step_fetcher = lambda { Step.where(node_id: node.id) }
        node.step_source = lambda { |args| Step.new( {node_id: node.id}.merge(args)) }
        node
      end
    }
    plan.node_source = lambda { |args|
      node = Node.new( {plan_id: plan.id}.merge(args))
      node.step_fetcher = lambda { Step.where(node_id: node.id) }
      node.step_source = lambda { |args| Step.new( {node_id: node.id}.merge(args)) }
      node
    }
    plan
  end

end
