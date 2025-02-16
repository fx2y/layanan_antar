module Api
  module V1
    class ServiceTemplatesController < BaseController
      before_action :set_service_template, except: [ :index, :create ]

      def index
        authorize ServiceTemplate
        @service_templates = policy_scope(ServiceTemplate)
                             .where(search_params)
                             .page(params[:page])
                             .per(params[:per_page])
        render json: @service_templates
      end

      def show
        authorize @service_template
        render json: @service_template
      end

      def create
        @service_template = ServiceTemplate.new(service_template_params)
        authorize @service_template
        @service_template.save!
        render json: @service_template, status: :created
      end

      def update
        authorize @service_template
        @service_template.update!(service_template_params)
        render json: @service_template
      end

      def destroy
        authorize @service_template
        @service_template.update!(status: :archived)
        head :no_content
      end

      private

      def set_service_template
        @service_template = ServiceTemplate.find(params[:id])
      end

      def service_template_params
        params.require(:service_template).permit(:name, :description,
                                               :pricing_schema, :service_area_schema)
      end

      def search_params
        params.permit(:status, :name).compact_blank
      end
    end
  end
end
