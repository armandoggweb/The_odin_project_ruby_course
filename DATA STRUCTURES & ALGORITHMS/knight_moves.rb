class Square
    attr_reader :row, :col
    attr_accessor :movements, :parent
    def initialize(row, col)
        @row = row #vertix
        @col = col
        @movements = [] #edges
        @parent = nil
    end
    def to_s
        "[#{@row}, #{@col}]"
    end
    def show_m
        l = []
        @movements.each {|m| l << m.to_s}
        l
    end
end
class Chess
    attr_reader :board
    def initialize
        @board = build_board
    end
    def build_board
        @board = Array.new(8){Array.new(8)}
        @board.each_index do |row|
            @board[row].each_index do |col|
                @board[row][col] = Square.new(row, col)
            end              
        end
    end
    def possible_movements
        @board.each_index do |row|
            @board.each_index do |col|
                square = @board[row][col]
                self.moves(square)
                #show(square)
            end
        end
    end

    def moves(current)
        (-2..2).each do |n|
            next if n == 0 || current.row + n > @board.length - 1 || current.row + n < 0
            n.abs == 2 ? m = 1 : m = 2
            2.times do
                m *= (-1)
                next if current.col + m > @board.length - 1 || current.col + m < 0
                current.movements << @board[current.row + n][current.col + m]
            end
        end
    end

    def knight_moves(start, target)
        queue = [@board[start.first][start.last]]
        visited = [@board[start.first][start.last]]
        target = @board[target.first][target.last]
        loop do
            current = queue.shift
            #show(current)
            visited << current unless visited.include?(current)
            current.movements.each do |square|
                unless visited.include?(square)
                    square.parent = current
                    queue << square 
                end
            end
            if current.movements.include?(target)
                target.parent = current
                visited << target
                break
            end
        end
        visited = visited_path(visited)
        puts "You made it in #{visited.length - 1} moves!  Heres your path:"
        visited.each{ |square| puts square.to_s}
    end
    def visited_path(visited)
        path = [visited.last]
        until path.last == visited.first
            path << path.last.parent 
        end
        path.reverse
    end
    def show(square)
        p square.to_s
        p square.show_m
    end
end


game = Chess.new
game.possible_movements
#game.show(game.board[3][3])
#game.show(game.board[1][2])

game.knight_moves([0, 0], [7, 7])

