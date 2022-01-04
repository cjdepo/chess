# lib/knight
require_relative '../mod/board_math.rb'
## The Knight piece can move forward, backward, left or right two squares and must then move one square in either perpendicular direction.
## The Knight piece can only move to one of up to eight positions on the board.
## The Knight piece can move to any position not already inhabited by another piece of the same color.
## The Knight piece can skip over any other pieces to reach its destination position.

class Knight
  include BoardMath
  attr_reader :moves, :position

  def initialize(position_arr, color)
    @position = position_arr
    @moves = [[1,2],[2,1],[-1,2],[2,-1],[1,-2],[-2,-1],[-2,1],[-1,-2]]
    @color = color
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


