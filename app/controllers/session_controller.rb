class SessionController < ApplicationController
    skip_before_action :verify_authenticity_token

    def user_login
        return if !validate_login_params.nil?
        user = nil
        user = User.find_by_email(login_params[:email])
        return render json: { success: false, error: 'Invalid User Credentials' }, status: :unauthorized unless user && login_params[:password]
        return render json: { success: false, error: 'Invalid Entries'}, status: :unauthorized unless (login_params['password'] == user['password'])
        render json: { success: true, user_id: user.id }
    end

    private
    
    def login_params
      params.require(:session).permit(:email, :password)
    end

    def validate_login_params 
      return render json: { success: false, error: 'Email Key Required' }, status: :unauthorized unless login_params[:email] && (login_params[:email].length > 0)
      return render json: { success: false, error: 'Password Key Required' }, status: :unauthorized unless login_params[:password] && (login_params[:password].length > 0)
    end
end
