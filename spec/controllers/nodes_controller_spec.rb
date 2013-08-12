require_relative '../spec_helper'

describe NodesController do
  describe "GET index" do
    it "responds with a json list of nodes" do
      get :index, :format => :json
      response.should be_success
      puts "GET index: #{response.body}"
    end
  end
end
