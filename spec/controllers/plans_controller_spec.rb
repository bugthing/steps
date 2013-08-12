require_relative '../spec_helper'

describe PlansController do

  describe "GET index" do
    it "responds with a json list of plans" do
      get :index, :format => :json
      response.should be_success
      puts "GET index: #{response.body}"
    end
  end
  describe "POST create" do
    let(:name) { 'New Plan' }
    let(:params) { {name: name, :class_name => 'String', :format => :json } }
    it "creates a new plan" do
      post :create, params
      response.should be_success
      puts "POST create: #{response.body}"
      #JSON.parse(response.body)
    end
  end

end
