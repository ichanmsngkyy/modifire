module Api
  module Auth
    class SessionsController < Devise::SessionsController
      respond_to :json
      skip_before_action :verify_signed_out_user, only: :destroy

      def create
        user_params = params.require(:user).permit(:username, :password)
        if user_params[:username].blank? || user_params[:password].blank?
          render json: {
            status: { code: 401, message: "Invalid username or password." }
          }, status: :unauthorized
          return
        end
        user = User.find_for_database_authentication(username: user_params[:username])

        if user && user.valid_password?(user_params[:password])
          # Generate JWT token manually
          token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first

          response.set_header("Authorization", "Bearer #{token}")

          render json: {
            status: { code: 200, message: "Logged in successfully." },
            data: { id: user.id, username: user.username, email: user.email }
          }, status: :ok
        else
          render json: {
            status: { code: 401, message: "Invalid username or password." }
          }, status: :unauthorized
        end
      end

      private

      def respond_to_on_destroy
         render json: {
            status: { code: 200, message: "Logged out successfully." }
          }, status: :ok
        # if current_user
        #   render json: {
        #     status: { code: 200, message: "Logged out successfully." }
        #   }, status: :ok
        # else
        #   render json: {
        #     status: { code: 401, message: "Couldn't find an active session." }
        #   }, status: :unauthorized
        # end
      end
    end
  end
end
