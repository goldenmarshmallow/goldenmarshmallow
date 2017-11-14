class Game < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :pieces

  def self.available
    where('white_player_id IS NULL OR black_player_id IS NULL')
  end
end
