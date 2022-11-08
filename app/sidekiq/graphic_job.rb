require 'sidekiq'
require 'sidekiq-cron'
class GraphicJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    GraphicGeneratorService.generate
  end
end
