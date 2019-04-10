# A grid showing the moves of players
class Board
  def initialize
    @items = Array.new(9, ' ')
  end

  def fill(sym, index)
    return false if %i[X O].include?(@items[index])

    @items[index] = sym
  end

  def show
    puts <<-HEREDOC
    \t\t\t\t\t     A   B   C
    \t\t\t\t\t   -------------
    \t\t\t\t\t 1 | #{@items[0]} | #{@items[1]} | #{@items[2]} |
    \t\t\t\t\t   -------------
    \t\t\t\t\t 2 | #{@items[3]} | #{@items[4]} | #{@items[5]} |
    \t\t\t\t\t   -------------
    \t\t\t\t\t 3 | #{@items[6]} | #{@items[7]} | #{@items[8]} |
    \t\t\t\t\t   -------------
    HEREDOC
  end
end

# The UI handler of the game
class UI
  def initialize(game)
    @game = game
    @board = Board.new
  end

  def legacy
    puts <<-HEREDOC
    \n\t\t\t\t ********************************
    \t\t\t\t *       TIC-TAC-TOE GAME       *
    \t\t\t\t * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    \t\t\t\t *        FABIEN/DARSHAN        *
    \t\t\t\t ********************************\n
    HEREDOC
  end

  def start
    legacy
    print "\n\n--> Player 1: "
    @game.add_player(1, gets.chomp)
    print "\n--> Player 2: "
    @game.add_player(2, gets.chomp)
    puts "---------------------\n\n"\
      "Choose cell to fill using (a1 or 1a, b2 or 2b, ...)\n\n"
    @board.show
    iterate
  end

  def fill(pos)
    @board.fill(@game.sym, pos)
  end

  def iterate
    loop do
      print "\n#{@game.next_player.name} move --> "
      input = gets.chomp
      handle_move(input)
    end
  end

  def handle_move(move)
    status = @game.next_move(move)
    @board.show
    case status
    when :wrong then puts "\n\t!! #{move} is invalid move !!"
    when :filled then puts "\n\t!! Cell #{move} is already filled !!"
    when :winner then winner
    when :draw then draw
    end
  end

  def winner
    puts "\n\t\t\t\t*************** #{@game.player.name} wins! ***************"
    end_game?
  end

  def draw
    puts "\n    \t\t\t~~ Draw game! It was a very tight battle. ~~"
    end_game?
  end

  def end_game?
    print "\n Do you want to play again? (y if yes, n if not): "
    if gets.chomp.casecmp?('y')
      @game.restart
    else
      puts "\n\t\t\t\t---->   See you next time!   <----\n"
      @game.stop
    end
  end
end
