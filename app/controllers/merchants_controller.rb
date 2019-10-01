class MerchantsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_merchant, only: [:show, :destroy]

  # GET /merchants
  # GET /merchants.json
  def index
    @merchants = Merchant.all
  end

  # GET /merchants/1
  # GET /merchants/1.json
  def show
  end

  # POST /merchants
  # POST /merchants.json
  def create
    outcome = Merchants::Create.run(merchant_params)

    # Then check to see if it worked:
    if outcome.success?
      render json: { mechant: outcome.result }, status: :ok
    else
      render json: outcome.errors.symbolic, status: 422
    end
  end

  # PATCH/PUT /merchants/1
  # PATCH/PUT /merchants/1.json
  def update
    outcome = Merchants::Update.run({ id: params[:id] }, merchant_params)
    
    if outcome.success?
      render json: { mechant: outcome.result }, status: :ok
    else
      render json: outcome.errors.symbolic, status: 422
    end
  end

  # DELETE /merchants/1
  # DELETE /merchants/1.json
  def destroy
    @merchant.destroy
    
    head :no_content
  end

  private

    # Set merhcant
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merchant_params
      params.require(:merchant).permit(:name, :email, :description, :status)
    end
end
