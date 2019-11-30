class Tictactoe
    attr_accessor :board
    def initialize 
        @board = Array.new(3){Array.new(3, "-")}
    end
    def draw_board
        @board.each do |row|
            puts row.join(" ")
        end
    end
    def choice (player, row = gets.chomp, col = gets.chomp )
        row = row.to_i
        col = col.to_i
        @board[row][col] = player
    end
    def win?(player)
        @board.each do |row|
            return true if row.count(player) == 3
        end
        temp = @board.transpose
        
        temp.each do |row|
            return true if row.count(player) == 3
        end
        return true if @board[0][0] == player && @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]
        return true if @board[0][2] == player && @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]
        false
    end
    def game
        player_1 = "player 1"
        player_2 = "player 2"
        winner = ""
        puts "Start"
        loop do
            self.draw_board

            puts "Introduce a cell, #{player_1}"
            self.choice("x")
            self.draw_board
            if self.win?("x")
                winner = player_1 
                break 
            end

            puts "Introduce a cell, #{player_2}"
            self.choice("o")
            self.draw_board
            if self.win?("o")
                winner = player_2 
                break 
            end
        end
        puts "The winner is #{winner}"
    end
end



