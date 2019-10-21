class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :password, length: { minimum: 4, maximum: 10 }, presence: true
    validates :phone_number, presence: true
end
