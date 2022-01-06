# lib/bishop

require_relative '../mod/board_math'

## The bishop can move in any direction diagonally, so long as it is not obstructed by another piece.
## The bishop piece cannot move past any piece that is obstructing its path.
# The bishop can take any other piece on the board that is within its bounds of movement.


class Bishop
  include BoardMath
  attr_reader :moves, :position, :color, :unicode

  def initialize(board, position_arr, color)
    @board = board
    @position = position_arr
    @directions = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
    @color = color
    if @color == 'black'
      @unicode = "\u265d"
    elsif @color == 'white'
      @unicode = "\u2657"
    end
  end

  def possible_moves
    possible_positions = []
    @directions.each do |direction|
      next_position = direction.map.with_index{ |v, i| v + @position[i] }
      if next_position.any? { |v| v > 8 || v < 1 }
        next
      end
      while @board[arr_to_position(next_position)] == nil 
        possible_positions << next_position
        next_position = direction.map.with_index{ |v, i| v + next_position[i] }
        if next_position.any? { |v| v > 8 || v < 1 }
          break
        end
        if @board[arr_to_position(next_position)] != nil
          if @board[arr_to_position(next_position)].color != @color
            possible_positions << next_position
            break
          end
        end
      end
    end
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


