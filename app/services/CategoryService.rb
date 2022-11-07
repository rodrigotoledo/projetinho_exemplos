class CategoryService
  def self.update_screen
    Turbo::StreamsChannel.broadcast_update_to("categories_service", target: "categories", partial: 'welcome/random')
  end
end