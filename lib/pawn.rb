# lib/pawn

require_relative '../mod/board_math'

## Pawn chess pieces can only directly forward one square, with two exceptions.
## Pawns can move directly forward two squares on their first move only.
## Pawns can move diagonally forward when capturing an opponent's chess piece.
# Once a pawn chess piece reaches the other side of the chess board, the player may "trade" the pawn in for any other chess piece if they choose, except another king.

class Pawn
  include BoardMath
  attr_reader :moves, :color, :position, :unicode, :prev_position, :move_count

  def initialize(board, position_arr, color, move_count=0)
    @board = board
    @position = position_arr
    @move_count = move_count
    @color = color
    @prev_position = nil
    if @color == 'white'
      @unicode = "\u265f"
      @direction = 1
    elsif @color == 'black'
      @unicode = "\u2659"
      @direction = -1
    end
  end

  def possible_moves
    plus_one_arr = [1*@direction,0].map.with_index{ |v, i| v + @position[i] }
    if plus_one_arr.any?{ |v| v < 1 || v > 8 }
      plus_one = 'off-board'
    else
      plus_one = @board[arr_to_position(plus_one_arr)]
    end
    plus_two_arr = [2*@direction,0].map.with_index{ |v, i| v + @position[i] }
    if plus_two_arr.any?{ |v| v < 1 || v > 8 }
      plus_two = 'off-board'
    else
      plus_two = @board[arr_to_position(plus_two_arr)]
    end
    if !plus_one && !plus_two
      if @move_count == 0
        moves = [[1*@direction, 0], [2*@direction, 0]]
      else
        moves = [[1*@direction, 0]]
      end
    elsif !plus_one
      moves = [[1*@direction, 0]]
    else
      moves = []
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
      @prev_position = @position
      @position = target_arr
      @move_count += 1
    end
  end

  def undo_move
    @position = @prev_position
    @move_count -=1
  end
  
end
