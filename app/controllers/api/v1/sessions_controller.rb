module Api
  module V1
    class SessionsController < Api::V1::BaseController
      before_action :authenticate_user, except: [:login]

      def login
        @user = User.find_for_authentication(email: params[:email])
        valid_password = @user.try(:valid_password?, params[:password])

        unless valid_password
          render json: {
            message: "The email address or password you entered is incorrect."
          }, status: :unprocessable_entity
        else
          _, @user_token = UserTokens::Services::Create.run(@user)
        end
      end

      def logout
        user_token = UserToken.find_by(token: request.headers['User-Access-Token'])
        user_token.destroy if user_token.present?

        render json: {message: "You have successfully logged out."}, status: :ok
      end
    end
  end
end
