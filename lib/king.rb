# lib/king

require_relative '../mod/board_math'

## The king piece can move one single square in any direction.
## The king cannot move onto a square that is currently occupied by a piece from its own team.
# The king piece cannot move to any square that puts them into a "check" position.
# The king piece can participate in a move known as "castling", where the piece can move up to three squares while exchanging places with a rook chess piece.

class King
  include BoardMath
  attr_reader :moves, :position, :color, :unicode

  def initialize(board, position_arr, color)
    @board = board
    @position = position_arr
    @moves = [[1, 1], [0, 1], [-1, 1], [1, -1], [0, -1], [-1, -1], [1, 0], [-1, 0]]
    @color = color
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
      @position = target_arr
    end
  end

  def check
    if @color == 'black'
      opp_moves = get_all_moves('white')
    elsif @color == 'white'
      opp_moves = get_all_moves('black')
    end
    if opp_moves.include?(position_arr)
      true
    else
      false
    end
  end

end


