class Piece < ApplicationRecord
  belongs_to :game
  validates :color, presence: true
  validates :type, presence: true

  scope :white, ->() { where(color: 'white') }
  scope :black, ->() { where(color: 'black') }

  def self.at(x_position, y_position)
    Piece.find_by(x_position: x_position, y_position: y_position)
  end

  def black?
    color == 'black'
  end

  def white?
    color == 'white'
  end

  def to_unicode
    'piece'
  end
end
