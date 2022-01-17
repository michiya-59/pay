class Income < ApplicationRecord
  require 'nkf'
  belongs_to :supplier
  belongs_to :user
  accepts_nested_attributes_for :supplier

  attr_accessor :new_price

  validates :month, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 }
  validates :year, presence: true
  validates :user_id, presence: true

  def conversion
    self.new_price = NKF.nkf('-w -Z4', self.price)
    update_attribute(:price, new_price)
  end
end
