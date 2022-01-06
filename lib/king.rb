# lib/king

require_relative '../mod/board_math'

## The king piece can move one single square in any direction.
# The king cannot move onto a square that is currently occupied by a piece from its own team.
# The king piece cannot move to any square that puts them into a "check" position.
# The king piece can participate in a move known as "castling", where the piece can move up to three squares while exchanging places with a rook chess piece.

class King
  include BoardMath
  attr_reader :moves, :position, :color, :unicode

  def initialize(position_arr, color)
    @position = position_arr
    @moves = [[1, 1], [0, 1], [-1, 1], [1, -1], [0, -1], [-1, -1], [1, 0], [-1, 0]]
    @color = color
    if @color == 'black'
      @unicode = "\u265a"
    elsif @color == 'white'
      @unicode = "\u2654"
    end
  end

  def possible_moves
    possible_positions = add_moves_to_position(@moves, @position)
    possible_positions.map! do |pos|
      if pos.any?{ |v| v > 8 || v < 1 }
        nil
      else
        pos
      end
    end.compact!
    possible_positions
  end

  def change_position(target_arr)
    possible_targets = possible_moves
    unless possible_targets.include?(target_arr)
      puts "illegal move"
      return nil
    else
      @position = target_arr
    end
  end

end


