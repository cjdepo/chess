# lib/pawn

require_relative '../mod/board_math'

## Pawn chess pieces can only directly forward one square, with two exceptions.
# Pawns can move directly forward two squares on their first move only.
# Pawns can move diagonally forward when capturing an opponent's chess piece.
# Once a pawn chess piece reaches the other side of the chess board, the player may "trade" the pawn in for any other chess piece if they choose, except another king.

class Pawn
  attr_reader :moves

  def initialize(board, position_arr, color)
    @board = board
    @position = position_arr
    @color = color
    @move_count = 0
  end

  def possible_moves
    if move_count == 0
      moves = [[0,1],[0,2]]
    else
      moves = [[0,1]]
    end
    # if @board[]
    # if front left:
    # moves << [-1, 1]
    # if front right:
    # moves << [1, 1]
  end

  def change_position(target_arr)
    possible_targets = possible_moves
    unless possible_targets.include?(target_arr)
      puts "illegal move"
      return nil
    else
      @position = target_arr
      @move_count += 1
    end
  end
end
