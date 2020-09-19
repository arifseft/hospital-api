module Api
  module V1
    class UsersController < Api::V1::BaseController
      # skip_before_action :verify_authenticity_token, only: [:create]

      def create
        status, @user, @token = Users::Services::Create.run(user_params)

        if status != :created
          render json: {message: generate_message(@user)}, status: :unprocessable_entity
        else
          render json: {data: @user, token: @token}, status: :ok
        end
      end

      private

      def user_params
        params.permit(:full_name, :email, :password)
      end

      def generate_message(user)
        return "" if user.errors.messages.nil?

        if user.errors.full_messages.size > 1
          user.errors.full_messages.join(', ')
        else
          user.errors.full_messages.join
        end
      end
    end
  end
end