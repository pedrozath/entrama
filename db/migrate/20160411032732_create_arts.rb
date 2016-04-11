class CreateArts < ActiveRecord::Migration
  def change
    create_table :arts do |t|
      t.integer :collection_id
      t.integer :image_id

      t.timestamps null: false
    end
  end
end
