# lib/pawn

require_relative '../mod/board_math'

## Pawn chess pieces can only directly forward one square, with two exceptions.
## Pawns can move directly forward two squares on their first move only.
## Pawns can move diagonally forward when capturing an opponent's chess piece.
# Once a pawn chess piece reaches the other side of the chess board, the player may "trade" the pawn in for any other chess piece if they choose, except another king.

class Pawn
  include BoardMath
  attr_reader :moves, :color, :unicode

  def initialize(board, position_arr, color)
    @board = board
    @position = position_arr
    @move_count = 0
    @color = color
    if @color == 'white'
      @unicode = "\u265f"
      @direction = 1
    elsif @color == 'black'
      @unicode = "\u2659"
      @direction = -1
    end
  end

  def possible_moves
    if @move_count == 0
      moves = [[1*@direction, 0], [2*@direction, 0]]
    else
      moves = [[1*@direction, 0]]
    end
    front_right_arr = [1*@direction,1].map.with_index{ |v, i| v + @position[i] }
    front_right = @board[arr_to_position(front_right_arr)]
    unless front_right == nil
      unless front_right.color == @color
        moves << [1*@direction, 1]
      end
    end
    front_left_arr = [1*@direction,-1].map.with_index{ |v, i| v + @position[i] }
    front_left = @board[arr_to_position(front_left_arr)]
    unless front_left == nil
      unless front_left.color == @color
        moves << [1*@direction, -1]
      end
    end
    possible_positions = add_moves_to_position(moves, @position)
  end

  def change_position(target_arr)
    possible_targets = possible_moves
    p possible_targets
    unless possible_targets.include?(target_arr)
      puts "illegal move"
      return nil
    else
      @position = target_arr
      @move_count += 1
    end
  end
end
