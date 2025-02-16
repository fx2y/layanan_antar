module Api
  module V1
    class BaseController < ApplicationController
      include Pundit::Authorization
      before_action :authenticate_user!

      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from Pundit::NotAuthorizedError, with: :forbidden
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

      private

      def not_found
        render json: { error: "Resource not found" }, status: :not_found
      end

      def forbidden
        render json: { error: "Not authorized" }, status: :forbidden
      end

      def unprocessable_entity(exception)
        render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
      end

      def authenticate_user!
        if user_signed_in?
          super
        else
          render json: { error: "You need to sign in or sign up before continuing." }, status: :unauthorized
        end
      end
    end
  end
end
