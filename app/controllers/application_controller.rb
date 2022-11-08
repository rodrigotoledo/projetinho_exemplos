# frozen_string_literal: true

class ApplicationController < ActionController::Base
        # include DeviseTokenAuth::Concerns::SetUserByToken
  # protect_from_forgery unless: -> { request.format.json? }
  skip_before_action :verify_authenticity_token
  # before_action :authenticate_user!
end
