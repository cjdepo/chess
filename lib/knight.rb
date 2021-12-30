# lib/knight


class Knight
  attr_reader :moves

  def initialize(position_arr)
    @position = position_arr
    @moves = [[1,2],[2,1],[-1,2],[2,-1],[1,-2],[-2,-1],[-2,1],[-1,-2]]
  end

  def possible_moves
    possible_positions = @moves.map{|move| move.map.with_index{|v, i| v + @position[i]}}
    possible_positions.map! do |pos|
      if pos.any?{ |v| v > 8 || v < 1 }
        nil
      else
        pos
      end
    end.compact!
    possible_positions
  end
end

  