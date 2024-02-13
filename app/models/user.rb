# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  before_create :skip_confirmation
  def self.authenticate(email, password)
    user = User.find_or_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end


  private

  def skip_confirmation
    self.confirmed_at = DateTime.now
  end
end
