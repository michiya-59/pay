# frozen_string_literal: true

module SuppliersHelper
  # 本業か副業か判別している
  def supplier_which?(supplier_switch)
    if supplier_switch == 'false'
      '本業'
    else
      '副業'
    end
  end
end
