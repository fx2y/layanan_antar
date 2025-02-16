module Api
  module V1
    class MitraDriversController < BaseController
      before_action :set_mitra
      before_action :set_mitra_driver, except: [ :index, :create ]

      def index
        authorize MitraDriver
        @mitra_drivers = policy_scope(MitraDriver)
                          .where(mitra: @mitra)
                          .page(params[:page])
                          .per(params[:per_page])
        render json: @mitra_drivers
      end

      def show
        authorize @mitra_driver
        render json: @mitra_driver
      end

      def create
        @mitra_driver = @mitra.mitra_drivers.build(mitra_driver_params)
        authorize @mitra_driver
        @mitra_driver.save!
        render json: @mitra_driver, status: :created
      end

      def destroy
        authorize @mitra_driver
        @mitra_driver.destroy!
        head :no_content
      end

      private

      def set_mitra
        @mitra = Mitra.find(params[:mitra_id])
      end

      def set_mitra_driver
        @mitra_driver = @mitra.mitra_drivers.find(params[:id])
      end

      def mitra_driver_params
        params.require(:mitra_driver).permit(:driver_id)
      end
    end
  end
end
