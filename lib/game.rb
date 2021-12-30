# /lib/game
require_relative 'knight'
class Game
  attr_reader :board

  def initialize
    @rows = [1, 2, 3, 4, 5, 6, 7, 8]
    @columns = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    @positions = []
    @rows.each { |row| @columns.each{ |column| @positions << (row.to_s << column.to_s) }}
    @board = @positions.reduce({}) { |board, position| board[position] = nil; board }
  end

  def get_rows(board=@board)
    i = 0
    rows = []
    row = []
    @positions.each do |position|
      if i >= 8
        rows << row
        row = []
        i = 0
      end
      i += 1
      row << board[position]
    end
    rows
  end

  def position_to_arr(position)
    arr = []
    @rows.each do |row|
        if position[0] == row.to_s
            arr[0] = row.to_i
        end
    end
    @columns.each_with_index do |column, i|
        if position[1] == column.to_s
            arr[1] = i + 1
        end
    end
    arr
  end

  def arr_to_position(arr)
    position = ''
    @rows.each do |row|
        if arr[0] == row.to_i
            position[0] = row.to_s
        end
    end
    @columns.each_with_index do |column, i|
        if arr[1] == i + 1
            position[1] = column.to_s
        end
    end
    position
  end

  def print_board
    rows = get_rows(@board)
    p rows
    puts "          -------------------------"
    rows.each do |row|
      str = row.reduce("          |") do |str, row|
        str += " #{row} |"
      end
      puts str
      puts "          -------------------------"
    end
  end

  def start_board
    # generate and load pieces in starting position
    @board['1b'] = Knight.new(position_to_arr('1b'))
    @board['1g'] = Knight.new(position_to_arr('1g'))
  end
  
  def list_moves(piece_position)
    # calls for the piece to give a list of it's possible moves
    # checks this move against available board positions
    # return list of what's left
  end

  def move(piece_position, end_position)
    # positions = list_moves(piece_position)
    # if end_position is in positions
    # move the piece
    # else return error
  end

end

