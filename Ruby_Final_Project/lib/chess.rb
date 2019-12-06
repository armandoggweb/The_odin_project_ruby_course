require_relative 'chess_pieces.rb'
include Chess_pieces
class Square
    attr_reader :row, :col
    attr_accessor :movements, :parent, :content
    def initialize(row, col)
        @row = row
        @col = col
        @content = nil
    end
    def to_s
        "[#{@row}, #{@col}]"
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

    def set_team(color)
        rows = [0, 1] if color == "black"
        rows = [7, 6] if color == "white"
        second_row = rows.last

        rows.each do |row|
            @board[row].each_index do |i|
                
                unless row == second_row
                    @board[row][i].content = Rook.new(color) if i == 0 || i == 7                    
                    @board[row][i].content = Knight.new(color) if i == 1 || i == 6 
                    @board[row][i].content = Bishop.new(color) if i == 2 || i == 5
                    @board[row][i].content = King.new(color) if i == 3
                    @board[row][i].content = Queen.new(color) if i == 4
                else
                    @board[row][i].content = Pawn.new(color)
                end
            end
        end
    end

    def draw_board
        alternate_color = true
        ('a'..'h').each{|char| print " #{char} "}
        puts
        @board.each_with_index do |row, i|
            alternate_color = !alternate_color
            row.each do |square|
                alternate_color = !alternate_color
                if alternate_color
                    if square.content.nil?
                        print "\e[43;30m   \e[0m"
                    else
                        print "\e[43;30m#{square.content.icon}\e[0m"
                    end
                else
                    if square.content.nil?
                        print "\e[46;30m   \e[0m"
                    else
                        print "\e[46;30m#{square.content.icon}\e[0m"
                    end
                end            
            end
            print " #{i + 1}"
            puts
        end
    end

    def move_parser(position)
        move = []
        character = ''
        number = ''
        if position.match(/[a-h][1-8]/)
            character = position[0]
            number = position[1]
        elsif position.match(/[1-8][a-h]/)
            character = position[1]
            number = position[0]
        else
            return nil
        end
            move << number.to_i - 1
            ('a'..'h').each_with_index{|char, i| move << i if character == char}
        move
    end

    def get_move(invalid_move = false)
        moves = {}
        unless invalid_move
            puts "What piece do you want to move?"
        else
            puts "Wrong move. Move another piece. Which piece do you wish to move?:"
        end
        moves[:origin] = move_parser(gets.chomp)
        puts "To:"
        moves[:target] = move_parser(gets.chomp)
        moves
    end
    
    def any_obstacle?(origin, target)
        c_origin = @board[origin.first][origin.last].content
        c_target = @board[target.first][target.last].content

        path = c_origin.get_path_target(origin, target)

        origin_color = c_origin.color unless c_origin.nil?
        target_color = c_target.color unless c_target.nil?

        path.each do |position|
             
            return true if @board[position.first][position.last].content != nil && position != target
            return true if position == target && origin_color == target_color
        end
        false
    end

    def pawn_wrong_taking?(origin, target)
        c_origin = @board[origin.first][origin.last].content

        if c_origin.is_a?(Pawn)
            c_target = @board[target.first][target.last].content
            if c_origin.get_take_moves(origin).include?(target)
                if c_target.nil? || c_origin.color == c_target.color
                    return true
                end
            end     
        end
        false
    end
    def move_piece(origin, target)
        @board[target.first][target.last].content = @board[origin.first][origin.last].content
        @board[origin.first][origin.last].content = nil
    end
    def legal_move?(origin, target)
        current = @board[origin.first][origin.last].content
        if !current.nil? && current.legal_move?(origin, target)
            unless current.is_a?(Knight)
                if any_obstacle?(origin, target) || pawn_wrong_taking?(origin, target)
                    return false
                end
            end
        else
            return false
        end
        true
    end
    def player_choice(color)
        move = get_move()
        unless move[:origin].nil?
            origin = @board[move[:origin].first][move[:origin].last].content
            o_color = origin.color unless origin.nil?
        end
        until !move[:origin].nil? && !move[:target].nil? && legal_move?(move[:origin], move[:target]) && color == o_color
            move = get_move(true)
            origin = @board[move[:origin].first][move[:origin].last].content
            o_color = origin.color unless origin.nil?
        end
        move_piece(move[:origin], move[:target])
    end
    def check_mate?(color)
        @board.each do |row|
            row.each do |square|
                return false if square.content.is_a?(King) && square.content.color == color
            end
        end
        true
    end

    def play
        puts "Start!"
        set_team("black")
        set_team("white")
        draw_board()
        loop do
            
            puts "White moves!"
            player_choice("white")
            if check_mate?("black")
                puts "White wins!" 
                break
            end

            draw_board()
            puts "Black moves!"
            player_choice("black")
            draw_board()   
            if check_mate?("white")
                puts "Black wins!" 
                break
            end
        end
    end
end
game = Chess.new
game.play
#game.move_parser("9p")
