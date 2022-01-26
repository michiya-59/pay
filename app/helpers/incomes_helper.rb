# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
module IncomesHelper
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
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  end

  def now_date_year
    Time.zone.today.strftime('%Y')
  end

  # 本業または副業の年間収入を求めている
  def array_out_price(income_main_all)
    income_main_all.values.map(&:to_i).sum
  end

  # 副業収入から経費を引いた年間所得を求めている
  def annual_income(side_business, expense)
    array_out_price(side_business) - array_out_price(expense)
  end

  # 年間総収入を求めている
  def main_sub_total_price(main_income, sub_income)
    array_out_price(main_income) + array_out_price(sub_income)
  end

  # 年間総所得を求めている
  def total_annual_income(main_income, sub_income, expense)
    array_out_price(main_income) + annual_income(sub_income, expense)
  end

  # 税法上の扶養
  # 税法上の扶養は103万までのため,103万から年間収入を引いている
  def tax_calculation(income_main_all, side_business_income, expense_price_all)
    if side_business_income.present? # 副業収入があった場合
      main_business_incom_total = array_out_price(income_main_all) + annual_income(side_business_income, expense_price_all)
      income_tax = if main_business_incom_total <= 1_030_000
                     1_030_000 - main_business_incom_total
                   else
                     '103万円を超えて扶養を超えました。'
                   end
    else
      income_tax = 1_030_000 - array_out_price(income_main_all)
    end
    income_tax
  end

  # 社会保険上の扶養
  # 社会保険上の扶養は130万までのため,130万から年間収入を引いている
  def social_insurance_tax_calculation(income_main_all, side_business_income)
    total_social_insurance = 1_300_000 - main_sub_total_price(income_main_all, side_business_income)
    if total_social_insurance <= 0
      '130万円を超えて社会保険の扶養を超えました。'
    else
      total_social_insurance
    end
  end

  # 本業か副業か判別している
  def supplier_which?(supplier_switch)
    if supplier_switch == 'false'
      '本業'
    else
      '副業'
    end
  end

  def monthly_incomes(income, type)
    i = 1 # ループを回す時の回数を示す数字
    keys = 0 # ハッシュの中身の順番を示す数字
    hash = {}
    count = income.count

    # 12ケ月文の収入をループで回している。
    # 何をしているのか思い出すときはrails cでこのメソッドを同じようにコピーしてやれば実行結果がわかる
    12.times do
      case type
      when 'table'
        if keys < count
          if i == income.keys[keys][1]
            hash[[income.keys[keys][0], income.keys[keys][1]]] = income.values[keys].to_j.to_s
            keys += 1
          elsif income.present?
            hash[[income.keys[0][0], i]] = '0'
          else
            hash[[now_date_year, i]] = '0'
          end
        elsif income.present?
          hash[[income.keys[0][0], i]] = '0'
        else
          hash[[now_date_year, i]] = '0'
        end
      when 'graph'
        if keys < count
          if i == income.keys[keys][1]
            hash[["#{income.keys[keys][0]}年", "#{income.keys[keys][1]}月"]] = income.values[keys]
            keys += 1
          elsif income.present?
            hash[["#{income.keys[0][0]}年", "#{i}月"]] = '0円'
          else
            hash[["#{now_date_year}年", "#{i}月"]] = '0'
          end
        elsif income.present?
          hash[["#{income.keys[0][0]}年", "#{i}月"]] = '0円'
        else
          hash[["#{now_date_year}年", "#{i}月"]] = '0'
        end
      end
      i += 1
    end
    hash
  end

  # 各月の収入が年間収入の何パーセントなのか計算している
  def ration_to_the_whole(monthly_incom, total_income)
    result = (monthly_incom.to_f / total_income) * 100
    format('%.2f', result)
  end

  # 各月の収入の詳細画面のグラフ
  def monthly_incomes_grah(monthly_incomes)
    count = monthly_incomes.size
    i = 0
    hash = {}
    count.times do
      hash[["#{monthly_incomes[i].month}月", monthly_incomes[i].created_at.strftime('%m月%d日')]] = "#{monthly_incomes[i].price}円"
      i += 1
    end
    hash
  end
end
# rubocop:enable Metrics/AbcSize
