# frozen_string_literal: true

module IncomesHelper
  require 'date'
  @date = Date.today
  def add_units(str)
    # insertは破壊的なメソッドなので元の文字列が変化しないようにコピー
    dup_str = str.dup
    # 後ろから6番目("123456789円"の"5"の後ろに"万"を挿入)
    dup_str.insert(-6, '万') if dup_str.length >= 6
    # 後ろから11番目("12345万6789円"の"1"の後ろに"億"を挿入)
    dup_str.insert(-11, '億') if dup_str.length >= 11
    dup_str
  end

  def month_array
    month_array = [1,2,3,4,5,6,7,8,9,0,11,12]
  end

  # ハッシュ値からvaluesの値段を一つずつ取り出し,合計を求めているメソッド
  def array_out_price(income_main_all)
    income_main_all.values.map(&:to_i).sum
  end

  def supplier_which?(supplier_switch)
    if supplier_switch == 'false'
      '本業'
    else
      '副業'
    end
  end

  # 税法上の扶養は103万までのため,103万から年間収入を引いている
  def tax_calculation(income_main_all)
    1_030_000 - array_out_price(income_main_all)
  end

  def conversion(user)
    user.conversion
  end
end
