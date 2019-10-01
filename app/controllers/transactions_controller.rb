class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_transaction, only: [:show, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # POST /transactions
  # POST /transactions.json
  def create
    outcome = Transactions::Create.run({ merchant_id: params[:merchant_id] }, transaction_params)

    # Then check to see if it worked:
    if outcome.success?
      render json: { transaction: outcome.result }, status: :ok
    else
      render json: outcome.errors.symbolic, status: 422
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    outcome = Transactions::Update.run({ id: params[:id] }, transaction_params)
    
    if outcome.success?
      render json: { mechant: outcome.result }, status: :ok
    else
      render json: outcome.errors.symbolic, status: 422
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:merchant_id, :amount, :status)
    end
end
