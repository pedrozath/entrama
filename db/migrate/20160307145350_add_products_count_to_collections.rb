class AddProductsCountToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :products_count, :integer
  end
end
