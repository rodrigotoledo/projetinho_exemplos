# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    # @application = Doorkeeper::Application.find_by(name: 'Web client')
    # @application = {
    #   name: @application.name,
    #   client_id: @application.uid,
    #   client_secret: @application.secret,
    # }
    @categories = Category.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def generate_graphic
    # GraphicJob.perform_later
    GraphicGeneratorService.generate
  end
end
