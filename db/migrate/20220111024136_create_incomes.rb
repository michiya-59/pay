class CreateIncomes < ActiveRecord::Migration[7.0]
  def change
    create_table :incomes do |t|
      t.integer :month
      t.string :price
      t.integer :supplier_id
      t.integer :user_id
      t.boolean :is_side_business

      t.timestamps
    end
  end
end
