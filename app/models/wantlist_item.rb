class WantlistItem < ApplicationRecord
  belongs_to :wantlist
  belongs_to :card
end
