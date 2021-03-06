# mod/board_math

module BoardMath 
  def position_to_arr(position)
    rows = [1, 2, 3, 4, 5, 6, 7, 8]
    columns = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    arr = []
    rows.each do |row|
      if position[0] == row.to_s
        arr[0] = row.to_i
      end
    end
    columns.each_with_index do |column, i|
      if position[1] == column.to_s
        arr[1] = i + 1
      end
    end
    arr
  end

  def arr_to_position(arr)
    rows = [1, 2, 3, 4, 5, 6, 7, 8]
    columns = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    position = ''
    rows.each do |row|
      if arr[0] == row.to_i
          position[0] = row.to_s
      end
    end
    columns.each_with_index do |column, i|
      if arr[1] == i + 1
        position[1] = column.to_s
      end
    end
    position
  end

  def add_moves_to_position(moves, position)
    moves.map{|move| move.map.with_index{|xy, i| xy + position[i]}}
  end

  def get_all_pieces(color)
    if color == 'white'
      pieces = @board.values.select do |position|
        if position
          position.color == 'white'
        else
          false
        end
      end
      pieces
    elsif color == 'black'
      pieces = @board.values.select do |position|
        if position
          position.color == 'black'
        else
          false
        end
      end
      pieces
    end
  end


  def get_all_moves(color)
    pieces = get_all_pieces(color)
    if color == 'white' || color == 'black'
      moves = pieces.reduce([]) do |all_moves, piece|
        piece.possible_moves.reduce(all_moves) do |all_moves, move|
          all_moves << move
        end
      end
      moves
    else
      raise "argument must be 'black' or 'white'"
    end
  end

  def get_king(color)
    king = @board.values.select do |pos|
      if pos
        pos.class == King && pos.color == color
      else
        false
      end
    end
    king[0]
  end

end