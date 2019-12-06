require '../lib/chess'
require '../lib/chess_pieces'
include Chess_pieces
RSpec.describe Chess do
    describe ".pawn_wrong_taking?" do
        chess = Chess.new
        chess.set_team("black")
        it 'returns true if the player try a taking move to an empty square' do
            expect(chess.pawn_wrong_taking?([1, 0], [2, 1])).to be true
        end
        it 'returns true if the player try a taking move to a piece of the same color' do
            chess.board[2][1].content = Pawn.new('black')
            expect(chess.pawn_wrong_taking?([1, 0], [2, 1])).to be true
        end
        it 'returns false if the attempt of taking is right' do
            chess.board[2][1].content = Pawn.new('white')
            expect(chess.pawn_wrong_taking?([1, 0], [2, 1])).to be false
        end
    end
    describe '.move_piece' do 
        context 'remove the pieces once taken' do
            it 'works when a pawn is taking' do
                chess = Chess.new
                chess.set_team("black")
                pawn = chess.board[4][3].content = Pawn.new('white')
                chess.board[3][5].content = Pawn.new('black')
                white = chess.board[4][3]
                black = chess.board[3][5]
                chess.move_piece([white.row, white.col], [black.row, black.col])
                expect(chess.board[3][5].content).to eql(pawn)
            end
        end
    end
end
RSpec.describe Rook do
    rook = Rook.new('black')
    describe '.get_path_target' do
        it 'works when it goes up' do
            expect(rook.get_path_target([3, 3], [0, 3])).to eq([[2, 3], [1, 3], [0, 3]])
        end
        it 'works when it goes down' do
            expect(rook.get_path_target([3, 3], [7, 3])).to eq([[4, 3], [5, 3], [6, 3], [7, 3]])
        end
        it 'works when it goes to the right' do
            expect(rook.get_path_target([3, 3], [3, 6])).to eq([[3, 4], [3, 5], [3, 6]])
        end
        it 'works when it goes to the left' do
            expect(rook.get_path_target([3, 3], [3, 0])).to eq([[3, 2], [3, 1], [3, 0]])
        end
    end  
end
RSpec.describe Bishop do
    bishop = Bishop.new('black')
    describe '.get_path_target' do
        it 'works when it goes diagonally up-right' do
            expect(bishop.get_path_target([3, 3], [1, 5])).to eq([[2, 4], [1, 5]])
        end
        it 'works when it goes diagonally down-right' do
            expect(bishop.get_path_target([3, 3], [6, 6])).to eq([[4, 4], [5, 5], [6, 6]])
        end
        it 'works when it goes diagonally up-left' do
            expect(bishop.get_path_target([3, 3], [1, 1])).to eq([[2, 2], [1, 1]])
        end
        it 'works when it goes diagonally down-left' do
            expect(bishop.get_path_target([3, 3], [5, 1])).to eq([[4, 2], [5, 1]])
        end
    end 
end
RSpec.describe Pawn do
    describe '.potencial_moves' do
        context 'when it\'s black' do
            pawn = Pawn.new('black')
            context 'when it\'s in its initial position' do
                it 'can move even 2 steps' do
                    expect(pawn.potencial_moves([1, 3])).to eq([[3, 3], [2, 3], [2, 4], [2, 2]])
                end
            end
        end
        context 'when it\'s white' do
            pawn = Pawn.new('white')
            context 'when it\'s in its initial position' do
                it 'can move even 2 steps' do
                    expect(pawn.potencial_moves([6, 3])).to eq([[4, 3], [5, 3], [5, 4], [5, 2]])
                end
            end
        end
    end
    describe '.get_take_moves' do
        it 'returns the potencial take moves from its current position' do
            pawn = Pawn.new('white')
            expect(pawn.get_take_moves([5, 4])).to eq([[4, 5], [4, 3]])
        end
    end
end
