class TradeItem < ApplicationRecord
  belongs_to :trade
  has_many :cards
end
