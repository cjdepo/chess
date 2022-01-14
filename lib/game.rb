# /lib/game
require_relative 'knight'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'
require_relative '../mod/board_math'

class Game
  include BoardMath
  attr_reader :board,  :black_check, :white_check, :black_checkmate, :white_checkmate, :prev_end_piece, :prev_end_pos, :prev_start_piece, :prev_end_pos

  def initialize
    @rows = [1, 2, 3, 4, 5, 6, 7, 8]
    @columns = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    @positions = []
    @rows.each { |row| @columns.each{ |column| @positions << (row.to_s << column.to_s) }}
    @board = @positions.reduce({}) { |board, position| board[position] = nil; board }
    @black_check = false
    @white_check = false
    @black_checkmate = false
    @white_checkmate = false
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
    puts "\n\n"
    puts "          ---------------------------------"
    row_num = 1
    rows.each do |row|
      str = row.reduce("        #{row_num} |") do |str, pos|
        if pos == nil
          pos = "\u2004".encode('utf-8')
        else
          pos = pos.unicode.encode('utf-8')
        end
        str += " #{pos} |"
      end
      puts str
      puts "          ---------------------------------"
      row_num += 1
    end
    puts "            a   b   c   d   e   f   g   h  "
  end

  def start_board
    
    @board['1b'] = Knight.new(@board,position_to_arr('1b'), 'white')
    @board['1g'] = Knight.new(@board,position_to_arr('1g'), 'white')
    @board['8b'] = Knight.new(@board,position_to_arr('8b'), 'black')
    @board['8g'] = Knight.new(@board,position_to_arr('8g'), 'black')
    @board['2a'] = Pawn.new(@board,position_to_arr('2a'), 'white')
    @board['2b'] = Pawn.new(@board,position_to_arr('2b'), 'white')
    @board['2c'] = Pawn.new(@board,position_to_arr('2c'), 'white')
    @board['2d'] = Pawn.new(@board,position_to_arr('2d'), 'white')
    @board['2e'] = Pawn.new(@board,position_to_arr('2e'), 'white')
    @board['2f'] = Pawn.new(@board,position_to_arr('2f'), 'white')
    @board['2g'] = Pawn.new(@board,position_to_arr('2g'), 'white')
    @board['2h'] = Pawn.new(@board,position_to_arr('2h'), 'white')
    @board['7a'] = Pawn.new(@board,position_to_arr('7a'), 'black')
    @board['7b'] = Pawn.new(@board,position_to_arr('7b'), 'black')
    @board['7c'] = Pawn.new(@board,position_to_arr('7c'), 'black')
    @board['7d'] = Pawn.new(@board,position_to_arr('7d'), 'black')
    @board['7e'] = Pawn.new(@board,position_to_arr('7e'), 'black')
    @board['7f'] = Pawn.new(@board,position_to_arr('7f'), 'black')
    @board['7g'] = Pawn.new(@board,position_to_arr('7g'), 'black')
    @board['7h'] = Pawn.new(@board,position_to_arr('7h'), 'black')
    @board['1c'] = Bishop.new(@board,position_to_arr('1c'), 'white')
    @board['1f'] = Bishop.new(@board,position_to_arr('1f'), 'white')
    @board['8c'] = Bishop.new(@board,position_to_arr('8c'), 'black')
    @board['8f'] = Bishop.new(@board,position_to_arr('8f'), 'black')
    @board['1a'] = Rook.new(@board,position_to_arr('1a'), 'white')
    @board['1h'] = Rook.new(@board,position_to_arr('1h'), 'white')
    @board['8a'] = Rook.new(@board,position_to_arr('8a'), 'black')
    @board['8h'] = Rook.new(@board,position_to_arr('8h'), 'black')
    @board['1d'] = Queen.new(@board,position_to_arr('1d'), 'white')
    @board['8d'] = Queen.new(@board,position_to_arr('8d'), 'black')
    @board['1e'] = King.new(@board,position_to_arr('1e'), 'white')
    @board['8e'] = King.new(@board,position_to_arr('8e'), 'black')
  end
  
  
  def move(piece_position, end_position)
    piece = @board[piece_position]
    poss_moves = piece.possible_moves.map{ |move_arr| arr_to_position(move_arr) }
    target = @board[end_position]
    if piece.change_position(position_to_arr(end_position))
      @prev_end_pos = end_position
      @prev_start_pos = piece_position
      @prev_start_piece = piece
      @prev_end_piece = target
      @board[end_position] = piece
      @board[piece_position] = nil
      puts "#{piece.class} moved from #{piece_position} to #{end_position}"
      true
    else
      puts "Move not allowed!"
      false
    end
  end

  def unmove
    if @prev_start_piece
      @board[@prev_end_pos] = @prev_end_piece
      @board[@prev_start_pos] = @prev_start_piece
      @prev_start_piece.undo_move
    end
  end

  def start
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
    puts 'OK here we go...'
    puts 'When it is your turn, choose a piece on the board by typing its position in the number letter format (i.e. 5c, 7a).'
    puts 'When you choose a piece it will return a list of possible positions to move to.'
    puts 'At this point you can either type in one of the possible positions to move the piece...'
    puts '... or you can type "select" and select another piece.'
    loop do
      print_board
      puts "\n\n"
      puts "\n-----WHITE PLAYER-------"
      player_input('white')
      check('white')
      check('black')
      if @black_check
        puts "Black King in check!"
        checkmate
        if @black_checkmate
          p "WHITE PLAYER WINS!!!!!!!!"
        end
      elsif @white_check
        puts "White King in check!"
        checkmate
        if @white_checkmate
          p "BLACK PLAYER WINS!!!!!!!!"
        end
      end
      print_board
      puts "\n\n"
      puts "\n------BLACK PLAYER-------"
      player_input('black')
      check('white')
      check('black')
      if @black_check
        puts "Black King in check!"
      elsif @white_check
        puts "White King in check!"
      end
    end
  end

   def player_input(color)
    catch(:input) do
      loop do
        piece = nil
        until piece do
          puts "\nType a position and hit enter:   "
          piece_position = gets.chomp
          if @board[piece_position] == nil
            puts "\nNo piece on this position."
          elsif @board[piece_position].color != color
            puts "\nNot your piece!"
          else
            puts "\n"
            puts "Possible moves:"
            @board[piece_position].possible_moves.each{ |arr| puts arr_to_position(arr) }
            piece = @board[piece_position]
          end
        end
        loop do
          puts "\nTo select another piece, type 'select' and hit enter."
          puts "To move the piece, type a position listed above and hit enter."
          target = gets.chomp
          if target == 'select'
            break
          elsif move(piece_position, target)
            throw(:input)
          else
            puts "\nEnter a valid move!:"
            next
          end
        end
      end
    end
  end

  def check(king_color)
    black_moves = get_all_moves('black')
    white_moves = get_all_moves('white')
    black_king = get_king('black')
    white_king = get_king('white')
    if king_color == 'black'
      if white_moves.include?(black_king.position)
        @black_check = true
      else
        @black_check = false
      end
    end
    if king_color == 'white'
      if black_moves.include?(white_king.position)
        @white_check = true
      else
        @white_check = false
      end
    end
  end

  def checkmate
    blacks = get_all_pieces('black')
    whites = get_all_pieces('white')
    black_king = get_king('black')
    white_king = get_king('white')
    if @black_check
      whites.each do |white_piece| 
        white_piece.possible_moves.each do |end_pos|
          move(arr_to_position(white_piece.position), arr_to_position(end_pos))
          p 'hi'
          if !check('black')
            unmove
            return
          else
            unmove
          end
        end
      end
      @black_checkmate = true
    end
    if @white_check
      blacks.each do |black_piece| 
        black_piece.possible_moves.each do |end_pos|
          move(arr_to_position(black_piece.position), arr_to_position(end_pos))
          p 'hi'
          if !check('white')
            unmove
            return
          else
            unmove
          end
        end
      end
      @white_checkmate = true
    end
  end
end