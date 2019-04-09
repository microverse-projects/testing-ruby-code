require './lib/tic-tac-toe.rb'

RSpec.describe Game do
  game = Game.new
  game.add_player(1, 'Darshan') # X
  game.add_player(2, 'Fabien') # O

  it 'checks the move' do
    game.next_move('a1') # X
    expect(game.next_move('a1')).to eql(0) # Already used cell
    expect(game.next_move('21')).to eql(-1) # Wrong move
  end

  it 'checks the winner' do
    game.next_move('b1')  # O
    game.next_move('2a')  # X
    game.next_move('a3')  # O
    game.next_move('b2')  # X
    game.next_move('c2')  # O
    expect(game.next_move('3c').name).to eql('Darshan')
  end

  it 'checks a draw' do
    expect(game.next_move('')).to eql(:draw)
  end
end