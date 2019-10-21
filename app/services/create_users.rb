class CreateUsers
    def initialize(user_params)
        @user_params = user_params
    end
    
    def perform
        user = User.new(@user_params)
        ApplicationRecord.transaction do
            user.save!
        end
        user
    end
end