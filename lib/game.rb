# /lib/game
require_relative 'knight'
require_relative '../mod/board_math'

class Game
  include BoardMath
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
      i += 1
      if i >= 8
        row << board[position]
        rows << row
        row = []
        i = 0
      else 
        row << board[position]
      end
    end
    rows
  end

  def print_board
    rows = get_rows(@board)
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
    @board['1b'] = Knight.new(position_to_arr('1b'), 'black')
    @board['1g'] = Knight.new(position_to_arr('1g'), 'black')
    @board['8b'] = Knight.new(position_to_arr('8b'), 'white')
    @board['8g'] = Knight.new(position_to_arr('8g'), 'white')
  end
  
  def list_moves(piece_position)
    piece = @board[piece_position]
    if piece == nil
      return nil
    else
      piece.possible_moves
    end
  end
  
  def move(piece_position, end_position)
    piece = @board[piece_position]
    target = @board[end_position]
    if target == nil
      #need to make this code better, 
      if piece.change_position(position_to_arr(end_position))
        @board[end_position] = piece
        @board[piece_position] = nil
      end
    elsif target.color != piece.color
      if piece.change_position(position_to_arr(end_position))
        @board[end_position] = piece
        @board[piece_position] = nil
      end
    elsif target.color == piece.color
      puts "space taken"
    end
  end
    


      
end