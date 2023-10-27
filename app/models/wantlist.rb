class Wantlist < ApplicationRecord
  belongs_to :user

  has_many :wantlist_items
  has_many :cards, through: :wantlist_items
end
