require 'sidekiq'
require 'sidekiq-cron'
class HardJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    CategoryService.update_screen
  end
end
