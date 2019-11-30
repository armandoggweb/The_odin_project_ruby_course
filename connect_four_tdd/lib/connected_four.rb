class Holes
    attr_accessor :state, :position, :near_holes
    @@white = {"white":"\u26BD"}
    @@black = {"black":"\u26BE"}
    @@empty = {"empty":"\u26AA"}
    def initialize(row, column)
        @state = @@empty
        @position = [row, column]
        @near_holes = []
    end
    def near_holes_to_a
        res = []
        @near_holes.each do |hole|
            res << hole.position
        end
        res       
    end
    def row
        @postion.first
    end
    def col
        @position.last
    end
    def self.white
        @@white
    end
    def self.black
        @@black
    end
    def self.empty
        @@empty
    end
end

class Connected_four
    attr_accessor :board
    def initialize
        @board = build_board
    end

    def play
        turn = 1
        build_near_holes
        loop do
            puts "turn: #{turn}"
            drop = rand(7)
            drop = drop_piece(drop, "w")
            draw_board
            p drop.position
            break if win?(drop) || draw?
            puts
            drop = rand(7)
            drop = drop_piece(drop, "b")
            draw_board
            p drop.position
            break if win?(drop) || draw?
            puts
            turn += 1
        end
    end

    private
    
    def build_board
        @board = Array.new(6){Array.new(7)}
        @board.each_index do |row|
            @board[row].each_index do |col|
                @board[row][col] = Holes.new(row, col)
            end
        end
    end
    def draw_board
        @board.each_index do |row| 
            res = []
            @board[row].each_index do |col|
                res << @board[row][col].state.values
            end
            p res.join(" ")
        end
    end

    def build_near_holes
        @board.each_index do |row|
            @board[row].each_index do |col|
                possible_moves(row, col)
            end
        end
    end

    def possible_moves(row, column)
        hole = @board[row][column]
        (-1).upto(1) do |n|
            (-1).upto(1) do |m|
                next if (n == 0 && m == 0 || 
                        n == (-1) && m == 0 || 
                        row + n < 0 || 
                        row + n > (@board.length - 1) || 
                        column + m < 0 || 
                        column + m > (@board[0].length - 1))

                hole.near_holes << @board[row + n][column + m] 
            end
        end

    end

    def keep_potencial_moves(piece)
        moves = []
        piece.near_holes.each do |move|
            moves << move if piece.state == move.state
        end
        moves
    end

    def check_win(last_piece)
        count = 1
        keep_moves = keep_potencial_moves(last_piece)
        count += 1 unless keep_moves.empty?

        keep_moves.each_index do |index|

            row = keep_moves[index].position[0]
            row_move = row - last_piece.position[0]
            col = keep_moves[index].position[1]
            col_move = col - last_piece.position[1]

            2.times do

                if (row + row_move > @board.length - 1 || 
                        row + row_move < 0 ||
                        col + col_move > @board[0].length - 1 ||
                        col + col_move < 0)
                    break
                else 
                    if @board[row + row_move][col + col_move].state == last_piece.state
                        count += 1
                        row = row + row_move
                        col = col + col_move
                    else
                        break                    
                    end
                end
            end 

            count -= 1 if count == 3
            return true if count == 4
        end

        false
    end

    def win?(last_piece)
        return true if check_win(last_piece)
        keep_moves = keep_potencial_moves(last_piece)
        keep_moves.each do |move|
            return true if check_win(move)
        end
        false
    end

    def drop_piece(column, color)
        i = @board.length - 1
        
        while !@board[0][column].state[:empty]
            column = rand(7)
        end

        until i < 0 || @board[i][column].state[:empty]
            i -= 1
        end
        color == "w" ? color = Holes.white : color = Holes.black
        @board[i][column].state = color unless i < 0

        @board[i][column]
    end

    def draw?
        @board[0].each do |hole|
            return false if hole.state[:empty]
        end
        true
    end

end

game = Connected_four.new
game.play
