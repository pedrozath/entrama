class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :size
      t.string :type
      t.string :garb_type
      t.string :fabric
      t.string :color

      t.timestamps null: false
    end
  end
end
