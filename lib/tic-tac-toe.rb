# UI
class Board
  def initialize
    @items = Array.new(9, " ")
  end
  def fill(sym, index)
    return false if @items[index-1].is_a? Symbol
    @items[index-1] = sym
    show
    true
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
  def credit
    puts <<-HEREDOC
    \t\t\t\t ********************************
    \t\t\t\t *       TIC-TAC-TOE GAME       *
    \t\t\t\t * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    \t\t\t\t *        FABIEN/DARSHAN        *
    \t\t\t\t ********************************
    HEREDOC
    puts "\n"
  end
end

# LOGIC
class Player
  attr_reader :name
  def initialize(name)
    @name = name
    @moves = Move.new
  end
  def next_move(pos)
    @moves.next(pos)
  end
  def moves
    @moves.get
  end
end

class Move
  def initialize
    @track = []
  end
  def next(pos)
    @track.push(pos)
  end
  def get
    @track
  end
end

class Game
  WIN_POS = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  def initialize
    @players = {}
    @moves = 0
    @board = Board.new
  end

  def add_player(role, name)
    return false if @players[role]
    @players[role] = Player.new(name)
    @current_role = 1 if role == 1
    return true
  end

  def next_move(cell)
    return :wrong unless pos(cell)
    return :filled unless @board.fill(sym(@current_role), pos(cell))
    @players[@current_role].next_move(pos(cell))
    winner = check_winner
    return winner if winner
    return :draw if @moves == 9
    @current_role = @current_role == 1 ? 2 : 1
  end

  def check_winner
    WIN_POS.each { |item|
      win = (item&@players[@current_role].moves).length == 3
      return @players[@current_role] if win
    }
    return nil
  end

  def start
    @board.credit
    @board.show
    puts "\n\n"
    print "--> Player 1: "
    add_player(1, gets.chomp)
    print "\n--> Player 2: "
    add_player(2, gets.chomp)
    puts '---------------------'
    puts "\n Choose cell to fill using colum_index as a1 or 1a | b2 or 2b, ..."
    loop do
      print "\n#{@players[@current_role].name} move --> "
      input = gets.chomp
      case next_move(input)
      when -1; puts "\n\t!! #{input} is invalid move !!"
      when 0; puts"\n\t!! #{input} is already filled !!"
      end
    end
  end

  def restart
    initialize
    start
  end

  def stop
    puts "\n\t\t\t\t----> See you next time! <----\n"; exit
  end

  private
  def sym(role)
    case role
    when 1
      :X
    when 2
      :O
    end
  end

  def pos(cell)
    case cell.downcase
    when 'a1','1a'; 1
    when 'a2','2a'; 4
    when 'a3','3a'; 7
    when 'b1','1b'; 2
    when 'b2','2b'; 5
    when 'b3','3b'; 8
    when 'c1','1c'; 3
    when 'c2','2c'; 6
    when 'c3','3c'; 9
    else false
    end
  end
end