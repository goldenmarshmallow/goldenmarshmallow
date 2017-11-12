class Game < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :pieces

  def self.available
    where('game.user.count < 2') if game.user.count > 0
  end
end
