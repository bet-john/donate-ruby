class SessionController < ApplicationController
    skip_before_action :verify_authenticity_token
    def user_login
        return render json: { success: false, error: 'Email Key Required' }, status: :unauthorized unless login_params[:email] && (login_params[:email].length < 0)
        return render json: { success: false, error: 'Password Key Required' }, status: :unauthorized unless login_params[:password] && (login_params[:password].length < 0)
        user = nil
        user = User.find_by_email(login_params[:email])
        p "*****************"
        return render json: { success: false, error: 'Invalid User Credentials' }, status: :unauthorized unless user && login_params[:password]
        render json: { success: true, user_id: user.id }
    end
    private
    def login_params
      params.permit(:email, :password)
    end

end
