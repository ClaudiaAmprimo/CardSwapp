class Collection < ApplicationRecord
  belongs_to :user
  # has_and_belongs_to_many :cards
  has_many :cards
end
