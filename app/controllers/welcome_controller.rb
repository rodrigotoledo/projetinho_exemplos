# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @categories = Category.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
