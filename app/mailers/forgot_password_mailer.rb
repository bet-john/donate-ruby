class ForgotPasswordMailer < ApplicationMailer
     default from: 'aidan.nienow@ethereal.email'

    def email (email_id)
        @user = nil
        @url = "http://localhost:4200/sign-in"
        @user = User.find_by_email(email_id)
        mail(to: @user.email, subject: 'Forgot your password?')
      end
end
