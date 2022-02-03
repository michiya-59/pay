# frozen_string_literal: true

class ExpenseCategory < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 20 }
end
