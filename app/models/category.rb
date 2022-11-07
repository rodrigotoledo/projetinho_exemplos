class Category < ApplicationRecord
  def search
    broadcast_update_to(:results_from_model, target: 'results_from_model', partial: 'welcome/results',
                                             locals: { categories: Category.all })
  end
end
