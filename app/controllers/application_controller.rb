# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # include DeviseTokenAuth::Concerns::SetUserByToken
  # protect_from_forgery unless: -> { request.format.json? }
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :set_active_storage_current_host

  def set_active_storage_current_host
    #ActiveStorage::Current.host = request.base_url
  end
end
