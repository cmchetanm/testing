module Api
  module V1
    class MerchantsController < ApiController
      before_action :set_merchant, only: [:show, :destroy]

      # GET /merchants
      # GET /merchants.json
      def index
        @merchants = Merchant.all

        render_success_response({
          merchant: array_serializer.new(@merchants, serializer: MerchantSerializer)
        })
      end

      # POST /merchants/upload_users
      def upload_users
        processed = []
        unprocessed = []

        ::CSV.foreach(params[:merchant][:csv].path, headers: true) do |row|
          row_hash = row.to_hash
          outcome = Merchants::Create.run(row_hash)

          if outcome.success?
            processed << outcome.result
          else
            unprocessed << row_hash
          end
        end

        render_success_response({ processed_merchants: processed, unprocessed_merchants: unprocessed })
      end

      # GET /merchants/1
      # GET /merchants/1.json
      def show
        render_success_response({
          merchant: single_serializer.new(@merchant, serializer: MerchantSerializer)
        })
      end

      # POST /merchants
      # POST /merchants.json
      def create
        outcome = Merchants::Create.run(merchant_params)

        # Then check to see if it worked:
        if outcome.success?
          render_success_response({ merchant: outcome.result })
        else
          render_unprocessable_entity(outcome.errors.symbolic)
        end
      end

      # PATCH/PUT /merchants/1
      # PATCH/PUT /merchants/1.json
      def update
        outcome = Merchants::Update.run({ id: params[:id] }, merchant_params)

        if outcome.success?
          render_success_response({ merchant: outcome.result })
        else
          render_unprocessable_entity(outcome.errors.symbolic)
        end
      end

      # DELETE /merchants/1
      # DELETE /merchants/1.json
      def destroy
        @merchant.destroy
        
        render_success_response({}, "Merchants  successfully deleted", status = 200)
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
  end
end
