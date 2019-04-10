require './lib/logic.rb'

describe Game do

  let(:game) {Game.new}

  before do
    # game
    game.add_player(1, 'Darshan') # X
    game.add_player(2, 'Fabien') # O
  end

  it 'returns game players' do
    expect(game.players[1].name).to eql('Darshan')
    expect(game.players[2].name).to eql('Fabien')
  end

  it 'checks the move' do
    game.next_move('a1') # X
    expect(game.next_move('a1')).to eql(:filled) # Already filled cell
    expect(game.next_move('21')).to eql(:wrong) # Wrong move
  end

  it 'checks the winner' do
    game.next_move('a1') # X
    game.next_move('b1') # O
    game.next_move('2a') # X
    game.next_move('a3') # O
    game.next_move('b2') # X
    game.next_move('c2') # O
    game.next_move('3c') # X
    expect(game.player.name).to eql('Darshan')
  end

  it 'checks a draw' do
    game.next_move('a1')  # X
    game.next_move('b2')  # O
    game.next_move('a2')  # X
    game.next_move('a3')  # O
    game.next_move('c1')  # X
    game.next_move('b1')  # O
    game.next_move('b3')  # X
    game.next_move('c2')  # O
    expect(game.next_move('c3')).to eql(:draw)
  end
end
