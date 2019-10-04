module Api
  module V1
    class TransactionsController < ApiController
      before_action :set_transaction, only: [:show, :destroy]

      # GET /transactions
      # GET /transactions.json
      def index
        @transactions = Transaction.all
        render_success_response({
          transaction: array_serializer.new(@transactions, serializer: TransactionSerializer)
        })
      end

      # GET /transactions/1
      # GET /transactions/1.json
      def show
        render_success_response({
          transaction: single_serializer.new(@transaction, serializer: TransactionSerializer)
        })
      end

      # POST /transactions
      # POST /transactions.json
      def create
        outcome = Transactions::Create.run({ merchant_id: params[:merchant_id] }, transaction_params)

        # Then check to see if it worked:
        if outcome.success?
          render_success_response({ transaction: outcome.result })
        else
          render_unprocessable_entity(outcome.errors.symbolic)
        end
      end

      # PATCH/PUT /transactions/1
      # PATCH/PUT /transactions/1.json
      def update
        outcome = Transactions::Update.run({ id: params[:id] }, transaction_params)

        if outcome.success?
          render_success_response({ transaction: outcome.result })
        else
          render_unprocessable_entity(outcome.errors.symbolic)
        end
      end

      # DELETE /transactions/1
      # DELETE /transactions/1.json
      def destroy
        @transaction.destroy
        render_success_response({}, "Transaction successfully deleted", status = 200)
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
  end
end
