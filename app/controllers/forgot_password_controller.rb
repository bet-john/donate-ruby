class ForgotPasswordController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def sent_password_email
        return if !validate_forgot_password_params.nil?
        user = nil
        user = User.find_by_email(forgot_password_params[:email])
        return render json: { success: false, error: 'Email ID doesnot exist' }, status: :unauthorized unless user
        ForgotPasswordMailer.email(forgot_password_params[:email]).deliver_now
        render json: { success: 'Email has been send to your email Id.', user_id: user.id }
    end

    private

    def forgot_password_params
      params.require(:forgot_password).permit(:email)
    end

    def validate_forgot_password_params 
      return render json: { success: false, error: 'Email Key Required' }, status: :unauthorized unless forgot_password_params[:email] && (forgot_password_params[:email].length > 0)
    end
end
