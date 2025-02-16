module Api
  module V1
    class SessionsController < Devise::SessionsController
      skip_before_action :verify_signed_out_user
      respond_to :json

      private

      def respond_to_on_destroy
        head :no_content
      end

      def verify_signed_out_user
        # Do nothing since we want to allow sign out without session
      end
    end
  end
end 