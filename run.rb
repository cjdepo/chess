# run

require_relative 'lib/game'

def start_menu
  puts "\n\nWelcome to Chess!\n"
  puts "If you would like to start a new game, type 'new'.\n"
  puts "If you would like to load a saved game, type 'load'.\n"
  puts "What's it gonna be?:  "
  while option = gets.chomp.downcase
      case option
      when 'new'
          current_game = Game.new
          current_game.load_new_game
          current_game.start
          break
      when 'load'
          current_game = Game.new
          current_game.load_saved_game
          current_game.start
          break
      else
          puts "\n\nPlease select either 'new' or 'load':   "
      end
  end
end

start_menu
