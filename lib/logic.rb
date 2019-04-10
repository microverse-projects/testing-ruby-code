require_relative './ui.rb'

# LOGIC
# Store the player informations
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

# Track the players move
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

# Represent the game functionality
class Game
  WIN_POS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
    [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
  ].freeze
  attr_reader :moves, :players, :player
  def initialize
    @players = {}
    @moves = 0
    @ui = UI.new(self)
  end

  def add_player(role, name)
    return false if @players[role]

    @players[role] = Player.new(name)
    true
  end

  def next_player
    @player = @moves.even? ? @players[1] : @players[2]
  end

  def next_move(move)
    pos = pos(move)
    return :wrong unless pos

    return :filled unless @ui.fill(pos)

    next_player.next_move(pos)
    @moves += 1
    status
  end

  def status
    WIN_POS.each do |item|
      win = (item & @player.moves).length == 3
      return :winner if win
    end
    return :draw if @moves == 9

    :progress
  end

  def start
    @ui.start
  end

  def restart
    initialize
    start
  end

  def stop
    exit
  end

  def sym
    @moves.even? ? :X : :O
  end

  private

  def pos(cell)
    {
      'a1' => 0, '1a' => 0, 'a2' => 3, '2a' => 3, 'a3' => 6, '3a' => 6,
      'b1' => 1, '1b' => 1, 'b2' => 4, '2b' => 4, 'b3' => 7, '3b' => 7,
      'c1' => 2, '1c' => 2, 'c2' => 5, '2c' => 5, 'c3' => 8, '3c' => 8
    }[cell]
  end
end
