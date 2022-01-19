# frozen_string_literal: true

module IncomesHelper
  require 'date'
  date = Time.zone.today.strftime('%Y')
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
    month_arrays = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
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

  def monthly_incomes(monthly_income, type)
    i = 1 # ループを回す時の回数を示す数字
    keys = 0 # ハッシュの中身の順番を示す数字
    hash = {}
    count = monthly_income.count

    # 12ケ月文の収入をループで回している。
    # 何をしているのか思い出すときはrails cでこのメソッドを同じようにコピーしてやれば実行結果がわかる
    12.times do
      case type
      when 'table'
        if keys < count
          if i == monthly_income.keys[keys][1]
            hash[[monthly_income.keys[keys][0], monthly_income.keys[keys][1]]] = monthly_income.values[keys].to_j.to_s
            keys += 1
          elsif monthly_income.present?
            hash[[monthly_income.keys[0][0], i]] = '0'
          else
            hash[[date, i]] = '0'
          end
        elsif monthly_income.present?
          hash[[monthly_income.keys[0][0], i]] = '0'
        else
          hash[[date, i]] = '0'
        end
      when 'graph'
        if keys < count
          if i == monthly_income.keys[keys][1]
            hash[["#{monthly_income.keys[keys][0]}年", "#{monthly_income.keys[keys][1]}月"]] = monthly_income.values[keys]
            keys += 1
          elsif monthly_income.present?
            hash[["#{monthly_income.keys[0][0]}年", "#{i}月"]] = '0円'
          else
            hash[["#{date}年", "#{i}月"]] = '0'
          end
        elsif monthly_income.present?
          hash[["#{monthly_income.keys[0][0]}年", "#{i}月"]] = '0円'
        else
          hash[["#{date}年", "#{i}月"]] = '0'
        end
      end
      i += 1
    end
    hash
  end
end
