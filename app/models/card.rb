class Card < ApplicationRecord
  validates :name, :set, :rarity, :type, presence: true
  self.inheritance_column = :_type_disabled
  has_and_belongs_to_many :collections
  has_many :wantlist_items
  has_many :wantlists, through: :wantlist_items
end
