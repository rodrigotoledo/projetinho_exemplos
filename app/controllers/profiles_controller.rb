class ProfilesController < ApplicationController
  def search
    @users = params[:search].present? ? User.where('email LIKE ?', "%#{params[:search]}%").order(:email) : []
    respond_to do |format|
      format.turbo_stream
    end
  end
end
