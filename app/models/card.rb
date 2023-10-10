class Card < ApplicationRecord
  validates :name, :set, :rarity, :type, presence: true
end
