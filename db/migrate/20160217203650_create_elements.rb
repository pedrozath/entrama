class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
