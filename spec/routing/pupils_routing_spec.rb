require "spec_helper"

describe PupilsController do
  describe "routing" do

    it "routes to #index" do
      get("/pupils").should route_to("pupils#index")
    end

    it "routes to #new" do
      get("/pupils/new").should route_to("pupils#new")
    end

    it "routes to #show" do
      get("/pupils/1").should route_to("pupils#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pupils/1/edit").should route_to("pupils#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pupils").should route_to("pupils#create")
    end

    it "routes to #update" do
      put("/pupils/1").should route_to("pupils#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pupils/1").should route_to("pupils#destroy", :id => "1")
    end

  end
end
