# lib/queen

require_relative '../mod/board_math'


## The queen can move in any direction on a straight or diagonal path.
## The queen cannot "jump" over any piece on the board, so its movements are restricted to any direction of unoccupied squares.
## The queen can be used to capture any of your opponent's pieces on the board.



class Queen
  include BoardMath
  attr_reader :moves, :position, :color, :unicode, :prev_position

  def initialize(board, position_arr, color)
    @board = board
    @position = position_arr
    @directions = [[1, 1], [0, 1], [-1, 1], [1, -1], [0, -1], [-1, -1], [1, 0], [-1, 0]]
    @color = color
    @prev_position = nil
    if @color == 'white'
      @unicode = "\u265b"
    elsif @color == 'black'
      @unicode = "\u2655"
    end
  end

  def possible_moves
    possible_positions = []
    @directions.each do |direction|
      next_position = direction.map.with_index{ |v, i| v + @position[i] }
      if next_position.any? { |v| v > 8 || v < 1 }
        next
      end
      if @board[arr_to_position(next_position)] != nil && @board[arr_to_position(next_position)].color != @color
        possible_positions << next_position
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
      @prev_position = @position
      @position = target_arr
    end
  end

  def undo_move
    @position = @prev_position
  end

end