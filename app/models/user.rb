# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.authenticate(email, password)
    user = User.find_or_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end
end
