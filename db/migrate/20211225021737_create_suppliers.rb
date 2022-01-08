# frozen_string_literal: true

class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.boolean :is_side_business, null: false

      t.timestamps
    end
  end
end
