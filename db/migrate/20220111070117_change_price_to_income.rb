# frozen_string_literal: true

class ChangePriceToIncome < ActiveRecord::Migration[7.0]
  def change
    Income.update(price: nil)
    change_column :incomes, :price, :integer, using: 'price::integer'
  end
end
