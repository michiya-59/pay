# frozen_string_literal: true

class ExpenseCategory < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
end
