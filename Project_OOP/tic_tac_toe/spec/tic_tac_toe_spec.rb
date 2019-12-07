require '../tic_tac_toe.rb'
RSpec.describe Tictactoe do
    describe '.choice' do
        context 'player make a choice' do
            it 'adds the player symbol in the chosen board\'s place' do
                juego = Tictactoe.new
                #juego.choice('x', 0, 0)
                #allow(juego).to receive(:choice).with('x', 0, 0).and_return('x')
                #expect(juego.board[0][0]).to eq('x')
                expect(juego.choice('x', 0, 0)).to eq('x')
            end
        end

    end
    describe '.win?' do
        it 'returns true if some player has won' do
            game = Tictactoe.new
            game.board[0][0] = 'x'
            game.board[1][1] = 'x'
            game.board[2][2] = 'x'
            expect(game.win?('x')).to be true
        end
        it 'returns false if any player has won' do
            game = Tictactoe.new
            game.board[0][0] = 'x'
            game.board[1][1] = 'o'
            game.board[2][2] = 'x'
            expect(game.win?('x')).to be false
        end
    end

end