module ExpensesHelper
  def month_array
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  end
  
  # ハッシュ値からvaluesの値段を一つずつ取り出し,合計を求めているメソッド
  def array_out_price(expense_price_all)
    income_main_all.values.map(&:to_i).sum
  end
end
