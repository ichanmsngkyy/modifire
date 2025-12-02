class ApplicationController < ActionController::API
  private

  def ensure_admin
    unless current_user&.admin?
      render json: { error: "Unauthorized" }, status: :forbidden
    end
  end
end
