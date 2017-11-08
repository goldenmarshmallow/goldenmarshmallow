class Game < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :pieces
end
