# mod/board_math

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