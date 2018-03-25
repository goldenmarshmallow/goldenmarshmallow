class Piece < ApplicationRecord
  belongs_to :game
  validates :color, presence: true
  validates :type, presence: true

  scope :white, -> { where(color: 'white') }
  scope :black, -> { where(color: 'black') }

  def black?
    color == 'black'
  end

  def white?
    color == 'white'
  end

  def to_unicode
    'piece'
  end

  def exist?(x_destination, y_destination)
    game.pieces.exists?(x_position: x_destination, y_position: y_destination)
  end

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

  def move_to!(new_x, new_y)
    if exist?(new_x, new_y)
      piece_at_destination = game.pieces.find_by(x_position: new_x, y_position: new_y)
      return 'destination occupied by piece of same color' if color == piece_at_destination.color
      piece_at_destination.update(x_position: nil, y_position: nil)
    end
    update(x_position: new_x, y_position: new_y)
  end

  def valid_move?(_destination_x, _destination_y)
    'Valid move'
  end
end
