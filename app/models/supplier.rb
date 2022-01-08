# frozen_string_literal: true

class Supplier < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
end
