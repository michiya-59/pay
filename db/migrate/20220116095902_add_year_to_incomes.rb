class AddYearToIncomes < ActiveRecord::Migration[7.0]
  def change
    add_column :incomes, :year, :integer
  end
end
