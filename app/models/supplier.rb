# frozen_string_literal: true

class Supplier < ApplicationRecord
  has_many :income
  belongs_to :user
  validates :name, presence: true, length: { maximum: 20 }
end
