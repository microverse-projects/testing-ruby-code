require './lib/tic_tac_toe.rb'

# Init game1
game1 = Game.new
game1.add_player(1, 'Darshan') # X
game1.add_player(2, 'Fabien') # O

# Init game2
game2 = Game.new
game2.add_player(1, 'Darshan') # X
game2.add_player(2, 'Fabien') # O

describe Game do
  it 'checks the move' do
    game1.next_move('a1') # X
    expect(game1.next_move('a1')).to eql(:filled) # Already filled cell
    expect(game1.next_move('21')).to eql(:wrong) # Wrong move
  end

  it 'checks the winner' do
    game1.next_move('b1')  # O
    game1.next_move('2a')  # X
    game1.next_move('a3')  # O
    game1.next_move('b2')  # X
    game1.next_move('c2')  # O
    expect(game1.next_move('3c').name).to eql('Darshan')
  end

  it 'checks a draw' do
    game2.next_move('a1')  # X
    game2.next_move('b2')  # O
    game2.next_move('a2')  # X
    game2.next_move('a3')  # O
    game2.next_move('c1')  # X
    game2.next_move('b1')  # O
    game2.next_move('b3')  # X
    game2.next_move('c2')  # O

    expect(game2.next_move('c3')).to eql(:draw)
  end
end
