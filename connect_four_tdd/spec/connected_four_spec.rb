require '../lib/connected_four.rb'
RSpec.describe Holes do
    context 'class constructor' do
        
    end
end
RSpec.describe Connected_four do
    describe '.build_board' do
        it 'creates a board made of a two-dimesional array' do
            expect(Connected_four.new.board).to be_kind_of(Array)
        end
        it 'creates a board with the right size' do
            game = Connected_four.new
            heigth = game.board.length
            width = game.board[0].length
            expect(heigth).to eq(6)
            expect(width).to eq(7)
        end
        it 'creates a board with holes of Holes type' do
            expect(Connected_four.new.board[rand(6)][rand(7)]).to be_kind_of(Holes)
        end
    end

    describe '#draw_board' do
        it 'draws the game in console' do
            expect{Connected_four.new.send(:draw_board)}.to output.to_stdout
        end
    end

    describe '#build_near_holes' do
        it 'adds the possible winning moves to each position of the board' do
            game = Connected_four.new
            game.send(:build_near_holes)
            expect(game.board[1][3].near_holes_to_a).to eq([[0, 2], [0, 4], [1, 2], [1, 4], [2, 2], [2, 3], [2, 4]])
        end
    end
    describe '#win?' do
        context 'determines if any player has won' do
            it 'returns true when there are 4 in an horizontal row' do
                game = Connected_four.new
                game.send(:build_near_holes)
                4.times{|n| game.board[5][6 - n].state = {"black":"\u26AB"}}
                expect(game.send(:win?, game.board[5][3])).to be true
            end
            it 'returns true when there are 4 in an vertical column' do
                game = Connected_four.new
                game.send(:build_near_holes)
                4.times{|n| game.board[5 - n][6].state = {"black":"\u26AB"}}
                expect(game.send(:win?, game.board[2][6])).to be true
            end
            it 'returns true when tehre are 4 in diagonal' do
                game = Connected_four.new
                game.send(:build_near_holes)
                4.times{|n| game.board[5 - n][6 - n].state = {"black":"\u26AB"}}
                expect(game.send(:win?, game.board[2][3])).to be true
            end
            it 'returns true when the last move it isn\'t on the extremes' do
                game = Connected_four.new
                game.send(:build_near_holes)
                [0, 1, 3].each{|n| game.board[5 - n][6 - n].state = {"black":"\u26AB"}}
                game.board[3][4].state = {"black":"\u26AB"}
                expect(game.send(:win?, game.board[3][4])).to be true
            end
        end
    end
    describe '#drop_piece' do
        context "when the player drops a piece" do
            it 'returns the hole chosen' do
                game = Connected_four.new
                game.send(:build_near_holes)
                expect(game.send(:drop_piece, 6, "w")).to eq(game.board[5][6])
            end

        end

    end
end