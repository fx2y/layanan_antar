module Api
  module V1
    class ServiceInstancesController < BaseController
      before_action :set_mitra
      before_action :set_service_instance, except: [ :index, :create ]

      def index
        authorize ServiceInstance.new, policy_class: ServiceInstancePolicy
        @service_instances = policy_scope(ServiceInstance)
                             .where(mitra: @mitra)
                             .where(search_params)
                             .page(params[:page])
                             .per(params[:per_page])
        render json: @service_instances
      end

      def show
        authorize @service_instance
        render json: @service_instance
      end

      def create
        @service_instance = @mitra.service_instances.build(service_instance_params)
        authorize @service_instance
        @service_instance.save!
        render json: @service_instance, status: :created
      end

      def update
        authorize @service_instance
        @service_instance.update!(service_instance_params)
        render json: @service_instance
      end

      def destroy
        authorize @service_instance
        @service_instance.update!(status: :archived)
        head :no_content
      end

      private

      def set_mitra
        @mitra = Mitra.find(params[:mitra_id])
      end

      def set_service_instance
        @service_instance = @mitra.service_instances.find(params[:id])
      end

      def service_instance_params
        params.require(:service_instance).permit(:name, :description,
                                               :pricing_details, :service_area,
                                               :service_template_id)
      end

      def search_params
        params.permit(:status, :service_template_id).compact_blank
      end

      def pundit_user
        { user: current_user, mitra: @mitra }
      end
    end
  end
end
