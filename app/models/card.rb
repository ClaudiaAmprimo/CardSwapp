class Card < ApplicationRecord
  validates :name, :set, :rarity, :type, presence: true
  self.inheritance_column = :_type_disabled
end
