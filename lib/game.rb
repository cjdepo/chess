# /lib/game

class Game 

  def initialize
    @rows = [1, 2, 3, 4, 5, 6, 7, 8]
    @columns = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    @positions = []
    @rows.each{ |row| @columns.each{ |column| @positions << (row.to_s << column.to_s) }}
  end

  def start_board
    # generate and load pieces in starting position
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


