module Api
  module V1
    class MitrasController < BaseController
      skip_before_action :authenticate_user!, only: [ :create ]
      before_action :set_mitra, except: [ :index, :create ]

      def index
        authorize Mitra
        @mitras = policy_scope(Mitra)
                   .where(search_params)
                   .page(params[:page])
                   .per(params[:per_page])
        render json: @mitras
      end

      def show
        authorize @mitra
        render json: @mitra
      end

      def create
        @mitra = Mitra.new(mitra_params)
        authorize @mitra
        @mitra.save!
        render json: @mitra, status: :created
      end

      def update
        authorize @mitra
        @mitra.update!(mitra_params)
        render json: @mitra
      end

      def destroy
        authorize @mitra
        @mitra.update!(status: :inactive)
        head :no_content
      end

      private

      def set_mitra
        @mitra = Mitra.find(params[:id])
      end

      def mitra_params
        params.require(:mitra).permit(:business_name, :business_address,
                                    :contact_person_name, :contact_person_phone,
                                    :email)
      end

      def search_params
        params.permit(:status, :business_name).compact_blank
      end
    end
  end
end
