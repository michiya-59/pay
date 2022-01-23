class RenameExpensesCategoryIdColumnToExpenses < ActiveRecord::Migration[7.0]
  def change
    rename_column :expenses, :expenses_category_id, :expense_category_id
  end
end
