# lib/piece


class Knight
  attr_reader :moves

  def initialize(position)
    @position = position
    @moves = [[1,2],[2,1],[-1,2],[2,-1],[1,-2],[-2,-1],[-2,1],[-1,-2]]
  end

  def possible_moves(position_arr)
    possible_positions = @moves.map{|move| move.map.with_index{|v, i| v + position_arr[i]}}
    possible_positions.map! do |pos|
      if pos.any?{ |v| v > 8 || v < 1 }
        nil
      else
        pos
      end
    end.compact!
    possible_positions
  end



    # convert position to [x, y] notation
    # add each moves to xy
    # filter out side of board values
    # return positions


end

knight = Knight.new('e3')
knight.possible_moves([7,5])


  