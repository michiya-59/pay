class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.integer :month, null: false
      t.integer :price, null: false
      t.integer :expenses_category_id, null: false
      t.integer :user_id, null: false
      t.integer :year, null: false

      t.timestamps
    end
  end
end
