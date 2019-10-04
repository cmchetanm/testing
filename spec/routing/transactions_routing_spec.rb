require "rails_helper"

RSpec.describe Api::V1::MerchantsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/v1/merchants/1/transactions").to route_to({"format"=>"json", "controller"=>"api/v1/transactions", "action"=>"index", "merchant_id"=>"1"})
    end

    it "routes to #show" do
      expect(:get => "/api/v1/merchants/1/transactions/1").to route_to({"format"=>"json", "controller"=>"api/v1/transactions", "action"=>"show", "merchant_id"=>"1", "id"=>"1"})
    end

    it "routes to #create" do
      expect(:post => "/api/v1/merchants/1/transactions").to route_to({"format"=>"json", "controller"=>"api/v1/transactions", "action"=>"create", "merchant_id"=>"1"})
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/v1/merchants/1/transactions/1").to route_to({"format"=>"json", "controller"=>"api/v1/transactions", "action"=>"update", "merchant_id"=>"1", "id"=>"1"})
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/v1/merchants/1/transactions/1").to route_to({"format"=>"json", "controller"=>"api/v1/transactions", "action"=>"update", "merchant_id"=>"1", "id"=>"1"})
    end

    it "routes to #destroy" do
      expect(:delete => "/api/v1/merchants/1/transactions/1").to route_to({"format"=>"json", "controller"=>"api/v1/transactions", "action"=>"destroy", "merchant_id"=>"1", "id"=>"1"})
    end
  end
end
