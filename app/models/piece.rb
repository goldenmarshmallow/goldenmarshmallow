class Piece < ApplicationRecord
  belongs_to :game
  validates :color, presence: true
  validates :type, presence: true

  scope :white, ->() { where(color: 'white') }
  scope :black, ->() { where(color: 'black') }

  def black?
    color == 'black'
  end

  def white?
    color == 'white'
  end

  def to_unicode
    'piece'
  end

  def exist?(x, y)
    game.pieces.exists?(x_position: x, y_position: y)
  end

  def check_path(x1, y1, x2, y2)
    if y1 == y2
      'horizontal'
    elsif x1 == x2
      'vertical'
    else
      # move diagonal
      (y2 - y1).to_f / (x2 - x1).to_f
    end
  end

  def obstructed?(destination_x, destination_y)
    x1 = x_position
    y1 = y_position
    x2 = destination_x
    y2 = destination_y
    path = check_path(x1, y1, x2, y2)
    # Horizontal condition
    # Horizontal from right to left
    if path == 'horizontal' && x1 < x2
      (x1 + 1).upto(x2 - 1) do |x|
        return true if exist?(x, y1)
      end
    end
    # Horizontal from left to right
    if path == 'horizontal' && x1 > x2
      (x1 - 1).downto(x2 + 1) do |x|
        return true if exist?(x, y1)
      end
    end
    # Vertical condition
    # Vertical down
    if path == 'vertical' && y1 < y2
      (y1 + 1).upto(y2 - 1) do |y|
        return true if exist?(x1, y)
      end
    end
    # Vertical up
    if path == 'vertical' && y1 > y2
      (y1 - 1).downto(y2 + 1) do |y|
        return true if exist?(x1, y)
      end
    end
    return false if %w[horizontal vertical].include?(path)
    # Diagonal conditions
    # Diagonal down
    if ((y2 - y1).to_f / (x2 - x1).to_f).abs == 1.0 && x1 < x2
      (x1 + 1).upto(x2 - 1) do |x|
        delta_y = x - x1
        y = y2 > y1 ? y1 + delta_y : y1 - delta_y
        return true if exist?(x, y)
      end
    end
    # Diagonal up
    if ((y2 - y1).to_f / (x2 - x1).to_f).abs == 1.0 && x1 > x2
      (x1 - 1).downto(x2 + 1) do |x|
        delta_y = x1 - x
        y = y2 > y1 ? y1 + delta_y : y1 - delta_y
        return true if exist?(x, y)
      end
    end
    # No straight line
    return false unless ((y2 - y1).to_f / (x2 - x1).to_f).abs != 1.0
    'Invalid Input'
  end

  def move_to!(new_x, new_y)
    if exist?(new_x, new_y)
      piece_at_destination = game.pieces.find_by(x_position: new_x, y_position: new_y)
      return 'destination occupied by piece of same color' if color == piece_at_destination.color
      piece_at_destination.update_attributes(x_position: nil, y_position: nil)
      true
    else false
    end
  end
end
