class PlansController < ApplicationController
  def index
    render json: @plans
  end
  def create
    data = { name: params[:name] }
    plan = AllPlans.new_plan(data)
    render json: plan
  end
end
