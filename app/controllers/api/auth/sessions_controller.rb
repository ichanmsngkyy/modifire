module Api
  module Auth
    class SessionsController < Devise::SessionsController
      respond_to :json
      skip_before_action :verify_signed_out_user, only: :destroy

      rescue_from NoMethodError do |exception|
        if exception.message.include?("find_for_jwt_authentication")
          render json: { error: "Invalid or expired token" }, status: :unauthorized
        else
          raise exception
        end
      end

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
      data: {
        id: user.id,
        username: user.username,
        email: user.email,
        role: user.role  # ADD THIS LINE - return role as integer (0 or 1)
      }
    }, status: :ok
  else
    render json: {
      status: { code: 401, message: "Invalid username or password." }
    }, status: :unauthorized
  end
end


      def failure
        render json: {
          status: { code: 401, message: "Invalid username or password." }
        }, status: :unauthorized
      end

      def current_user
        if current_user
          render json: { user: current_user }, status: :ok
        else
          render json: { error: "Not authenticated" }, status: :unauthorized
        end
      end

      private
      def respond_with(resource, _opts = {})
      render json: { user: resource }, status: :ok
      end
    end

    def respond_to_on_destroy
      head :no_content
    end
  end
end
