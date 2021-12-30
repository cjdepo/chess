# lib/knight

## The Knight piece can move forward, backward, left or right two squares and must then move one square in either perpendicular direction.
## The Knight piece can only move to one of up to eight positions on the board.
# The Knight piece can move to any position not already inhabited by another piece of the same color.
## The Knight piece can skip over any other pieces to reach its destination position.

class Knight
  attr_reader :moves, :position

  def initialize(position_arr)
    @position = position_arr
    @moves = [[1,2],[2,1],[-1,2],[2,-1],[1,-2],[-2,-1],[-2,1],[-1,-2]]
  end

  #haven't tested this yet
  def possible_moves(board)
    possible_positions = @moves.map{|move| move.map.with_index{|v, i| v + @position[i]}}
    possible_positions.map! do |pos|
      if pos.any?{ |v| v > 8 || v < 1 }
        nil
      else
        pos
      end
    end.compact!
    possible_positions.map! do |pos|
      if board[pos] != nil
        nil
      else
        pos
      end
    end.compact!
  end

  def move(target_arr)
    possible_targets = self.possible_moves
    if possible_targets.include?(target_arr)
      @position = target_arr
    else
      puts "Illegal move"
    end
  end
end


