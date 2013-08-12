class NodesController < ApplicationController
  before_filter :set_plan

  def index
    nodes = @plan.nodes
    render json: nodes
  end

  def create
    data = { name: params[:name] }
    node = @plan.new_node(data)
    render json: node
  end

  private 

  def set_plan
    @plan = @plans.first
  end

end
