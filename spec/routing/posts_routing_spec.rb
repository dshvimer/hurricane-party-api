require "rails_helper"

RSpec.describe PostsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/posts").to route_to("posts#index")
    end

    it "routes to #create" do
      expect(:post => "/posts").to route_to("posts#create")
    end

    it "routes to #destroy"
  end
end
