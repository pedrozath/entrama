class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :address
      t.float :freight
      t.string :status
      t.string :message

      t.timestamps null: false
    end
  end
end
