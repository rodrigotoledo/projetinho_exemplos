class QtyOfViewInCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :qty_of_views, :integer, default: 0
  end
end
