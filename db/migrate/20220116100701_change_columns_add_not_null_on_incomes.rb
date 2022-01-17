class ChangeColumnsAddNotNullOnIncomes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :incomes, :month, false
    change_column_null :incomes, :price, false
    change_column_null :incomes, :supplier_id, false
    change_column_null :incomes, :user_id, false
    change_column_null :incomes, :is_side_business, false
    change_column_null :incomes, :year, false

    change_column_null :expense_categories, :name, false
    change_column_null :expense_categories, :user_id, false
  end
end
