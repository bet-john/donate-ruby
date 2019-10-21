class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def create
    return validate_params  if !validate_params.nil?
    user = nil
    begin
      ApplicationRecord.transaction do
        service = CreateUsers.new(user_params)
        user = service.perform
      end
    end
    render json: { success: true, message: "Yay! You are now a member." } 
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :phone_number, :password)
    end

    def validate_params 
      return render json: { success: false, error: 'Please provide a valid name.' }, status: :unauthorized unless user_params[:name]
      return render json: { success: false, error: 'Please provide a valid email.' }, status: :unauthorized unless user_params[:email]
      return render json: { success: false, error: 'Please provide a valid contact number.' }, status: :unauthorized unless user_params[:phone_number]
      return render json: { success: false, error: 'Please provide a valid password.' }, status: :unauthorized unless user_params[:password]
    end
end
