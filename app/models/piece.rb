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

  # def check_path(x1, y1, x2, y2)
  #   if y1 == y2
  #     'horizontal'
  #   elsif x1 == x2
  #     'vertical'
  #   else
  #     # move diagonal
  #     (y2.to_i - y1.to_i).to_f / (x2.to_i - x1.to_i).to_f
  #   end
  # end

  # def obstructed?(destination_x, destination_y)
  #   x1 = x_position
  #   y1 = y_position
  #   x2 = destination_x
  #   y2 = destination_y
  #   path = check_path(x1, y1, x2, y2)
  #   # Horizontal condition
  #   # Horizontal from right to left
  #   if path == 'horizontal' && x1 < x2
  #     (x1.to_i + 1).upto(x2.to_i - 1) do |x|
  #       return true if exist?(x, y1)
  #     end
  #   end
  #   # Horizontal from left to right
  #   if path == 'horizontal' && x1 > x2
  #     (x1.to_i - 1).downto(x2.to_i + 1) do |x|
  #       return true if exist?(x, y1)
  #     end
  #   end
  #   # Vertical condition
  #   # Vertical down
  #   if path == 'vertical' && y1 < y2
  #     (y1.to_i + 1).upto(y2.to_i - 1) do |y|
  #       return true if exist?(x1, y)
  #     end
  #   end
  #   # Vertical up
  #   if path == 'vertical' && y1 > y2
  #     (y1.to_i - 1).downto(y2.to_i + 1) do |y|
  #       return true if exist?(x1, y)
  #     end
  #   end
  #   return false if %w[horizontal vertical].include?(path)
  #   # Diagonal conditions
  #   # Diagonal down
  # if ((destination_y.to_i - y_position.to_i).to_f / (destination_x.to_i - x_position.to_i).to_f).abs == 1.0 && (x_position.to_i < destination_x.to_i)
  #   (x_position.to_i + 1).upto(destination_x.to_i - 1) do |x|
  #     delta_y = x.to_i - x_position.to_i
  #     y = destination_y.to_i > y_position.to_i ? (y_position.to_i + delta_y.to_i) : (y_position.to_i - delta_y.to_i)
  #     return true if exist?(x, y)
  #   end
  # end
  # # Diagonal up
  # if ((destination_y.to_i - y_position.to_i).to_f / (destination_x.to_i - x_position.to_i).to_f).abs == 1.0 && (x_position.to_i > destination_x.to_i)
  #   (x_position.to_i - 1).downto(destination_x.to_i + 1) do |x|
  #     delta_y = x_position.to_i - x.to_i
  #     y = destination_y.to_i > y_position.to_i ? (y_position.to_i + delta_y.to_i) : (y_position.to_i - delta_y.to_i)
  #     return true if exist?(x, y)
  #   end
  # end
  #   # No straight line
  #   return false unless ((y2.to_i - y1.to_i).to_f / (x2.to_i - x1.to_i).to_f).abs != 1.0
  #   'Invalid Input'
  # end

  def obstructed?(destination_x, destination_y)
    if (destination_x.to_i - x_position.to_i).abs == (destination_y.to_i - y_position.to_i).abs
      flipped_x = x_position.to_i < destination_x.to_i
      flipped_y = y_position.to_i < destination_y.to_i
      x_range = flipped_x ? ((x_position.to_i)..(destination_x.to_i)) : ((destination_x.to_i)..(x_position.to_i))
      y_range = flipped_y ? ((y_position.to_i)..(destination_y.to_i)) : ((destination_y.to_i)..(y_position.to_i))
      x_array = flipped_x ? x_range.first(x_range.size).reverse : x_range.first(x_range.size)
      y_array = flipped_y ? y_range.first(y_range.size).reverse : y_range.first(y_range.size)

      coordinates = x_array.each_with_index.map do |x, index|
        { x: x, y: y_array[index] }
      end

      obstructions = coordinates.select do |coordinate|
        game.pieces.where(
          color: color,
          x_position: coordinate[:x],
          y_position: coordinate[:y]
        ).where.not(id: id).any?
      end
      obstructions.any?
    elsif destination_y.to_i == y_position.to_i
      range = x_position.to_i < destination_x.to_i ? ((x_position.to_i)...(destination_x.to_i)) : ((destination_x.to_i)...(x_position.to_i))
      game.pieces.where(
        color: color,
        x_position: range,
        y_position: y_position
      ).where.not(id: id).any?
    elsif destination_x.to_i == x_position.to_i
      range = y_position.to_i < destination_y.to_i ? ((y_position.to_i)...(destination_y.to_i)) : ((destination_y.to_i)...(y_position.to_i))
      game.pieces.where(
        color: color,
        x_position: x_position,
        y_position: range
      ).where.not(id: id).any?
    else
      'Invalid Input'
    end
  end

  # def vertical_obstruction?(_destination_x, destination_y)
  #   range = y_position.to_i < destination_y.to_i ? ((y_position.to_i)...(destination_y.to_i)) : ((destination_y.to_i)...(y_position.to_i))
  #   game.pieces.where(
  #     color: color,
  #     x_position: x_position,
  #     y_position: range
  #   ).where.not(id: id).any?
  # end
  #
  # def horizontal_obstruction?(destination_x, _destination_y)
  #   range = x_position.to_i < destination_x.to_i ? ((x_position.to_i)...(destination_x.to_i)) : ((destination_x.to_i)...(x_position.to_i))
  #   game.pieces.where(
  #     color: color,
  #     x_position: range,
  #     y_position: y_position
  #   ).where.not(id: id).any?
  # end
  #
  # def diagonal_obstruction?(destination_x, destination_y)
  #   x_range = x_position.to_i < destination_x.to_i ? ((x_position.to_i)...(destination_x.to_i)) : ((destination_x.to_i)...(x_position.to_i))
  #   y_range = y_position.to_i < destination_y.to_i ? ((y_position.to_i)...(destination_y.to_i)) : ((destination_y.to_i)...(y_position.to_i))
  #   x_array = x_range.first(x_range.size)
  #   y_array = y_range.first(y_range.size)
  #
  #   coordinates = x_array.each_with_index.map do |x, index|
  #     { x: x, y: y_array[index] }
  #   end
  #
  #   obstructions = coordinates.select do |coordinate|
  #     game.pieces.where(
  #       color: color,
  #       x_position: coordinate[:x],
  #       y_position: coordinate[:y]
  #     ).where.not(id: id).any?
  #   end
  #   obstructions.any?
  # end

  def move_to!(new_x, new_y)
    if exist?(new_x, new_y)
      piece_at_destination = game.pieces.find_by(x_position: new_x, y_position: new_y)
      return 'destination occupied by piece of same color' if color == piece_at_destination.color
      piece_at_destination.update_attributes(x_position: nil, y_position: nil)
    end
    update_attributes(x_position: new_x, y_position: new_y)
  end

  def valid_move?(_destination_x, _destination_y)
    'Valid move'
  end
end
