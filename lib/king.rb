# lib/king

require_relative '../mod/board_math'

## The king piece can move one single square in any direction.
## The king cannot move onto a square that is currently occupied by a piece from its own team.
# The king piece cannot move to any square that puts them into a "check" position.
# The king piece can participate in a move known as "castling", where the piece can move up to three squares while exchanging places with a rook chess piece.

class King
  include BoardMath
  attr_reader :moves, :position, :color, :unicode, :prev_position

  def initialize(board, position_arr, color)
    @board = board
    @position = position_arr
    @moves = [[1, 1], [0, 1], [-1, 1], [1, -1], [0, -1], [-1, -1], [1, 0], [-1, 0]]
    @color = color
    @prev_position = nil
    if @color == 'white'
      @unicode = "\u265a"
    elsif @color == 'black'
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
    possible_positions.map! do |arr|
      if @board[arr_to_position(arr)] != nil
        if @board[arr_to_position(arr)].color == @color
          nil
        else
          arr
        end
      else
        arr
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
      @prev_position = @position
      @position = target_arr
    end
  end

  def undo_move
    @position = @prev_position
  end

end


