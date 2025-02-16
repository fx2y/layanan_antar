module Api
  module V1
    class UsersController < BaseController
      skip_before_action :authenticate_user!, only: [:create]

      def create
        user = User.new(user_params)
        user.save!
        render json: user, status: :created
      end

      def me
        render json: current_user
      end

      def update
        current_user.update!(user_params)
        render json: current_user
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role, profile_data: {})
      end
    end
  end
end
