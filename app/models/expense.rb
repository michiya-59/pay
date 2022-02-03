# frozen_string_literal: true

class Expense < ApplicationRecord
  belongs_to :user

  validates :month, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }
  validates :year, presence: true
  validates :user_id, presence: true
end
