module Chess_pieces
    class Chess_pieces
        attr_reader :icon
        attr_reader :color
        def initialize(color)
            @icon = set_color(color)
            @color = color
        end
    
        def set_color(color, black, white)
            color = " #{black} " if color == "black"
            color = " #{white} " if color == "white"
            color
        end

        def diagonal_lines(row, column)
            movements = []
            ((0 - column)..(7 - column)).each do |m|
                unless m == 0
                    movements << [row + m, column + m] unless row + m > 7 || row + m < 0
                    movements << [row - m, column + m] unless row - m > 7 || row - m < 0
                end
            end
            movements.uniq
        end

        def vertical_line(row, column)
            movements = []
            ((0 - column)..(7 - column)).each do |m|
                movements << [row, column + m] unless m == 0
            end
            movements
        end

        def horizontal_line(row, column)
            movements = []
            ((0 - row)..(7 - row)).each do |n|
                movements << [row + n, column] unless n == 0
            end
            movements
        end

        def potencial_moves(origin_square)
        end

        def legal_move?(origin, target)
            return true if potencial_moves(origin).include?(target)
            false
        end  

        def get_path_target(origin, target)
            path = []
            y_moves = []
            x_moves = []
            y = origin.first - target.first
            x = origin.last - target.last
            if y < 0 
                (y..-1).each{|n| y_moves << n}
                y_moves.reverse!
            else
                 (1..y).each{|n| y_moves << n}
            end
            if x < 0
                (x..-1).each{|n| x_moves << n}
                x_moves.reverse!
            else
                (1..x).each{|n| x_moves << n}
            end
            x_moves.length.times{ y_moves << 0} if y == 0
            y_moves.length.times{ x_moves << 0} if x == 0

            y_moves.each_index{|i| path << [origin.first - y_moves[i], origin.last - x_moves[i]]}
            
            path
        end

    end

    class King < Chess_pieces

        def set_color(color, black = "\u265A", white = "\u2654")
            super
        end
        def potencial_moves(origin_square)
            movements = []
            row = origin_square.first
            column = origin_square.last
            (-1..1).each do |n|
                unless row + n > 7 || row + n < 0
                    (-1..1).each do |m|
                        unless n == 0 && m == 0 || column + m > 7 || column + m < 0 
                            movements << [row + n, column + m]
                        end
                    end
                end
            end
            movements
        end

    end

    class Queen < Chess_pieces
    
        def set_color(color, black = "\u265B", white = "\u2655")
            super
        end
        def potencial_moves(origin_square)
            movements = []
            row = origin_square.first
            column = origin_square.last

            movements << vertical_line(row, column)
            movements << horizontal_line(row, column)
            movements << diagonal_lines(row, column)
            movements.flatten!(1)
            movements
        end
        
    end
    class Rook < Chess_pieces     

        def set_color(color, black = "\u265C", white = "\u2656")
            super
        end
        def potencial_moves(origin_square)
            movements = []
            row = origin_square.first
            column = origin_square.last
            movements << vertical_line(row, column)
            movements << horizontal_line(row, column)
            movements.flatten!(1)
            movements
        end

    end

    class Bishop < Chess_pieces    

        def set_color(color, black = "\u265D", white = "\u2657")
            super
        end

        def potencial_moves(origin_square)
            row = origin_square.first
            column = origin_square.last
            diagonal_lines(row, column)
        end

    end

    class Knight < Chess_pieces    

        def set_color (color, black = "\u265E", white = "\u2658")
            super
        end
    
        def potencial_moves(origin_square)
            movements = []
            row = origin_square.first
            column = origin_square.last
            (-2..2).each do |n|
                next if n == 0 || row + n > 7 || row + n < 0
                n.abs == 2 ? m = 1 : m = 2
                2.times do
                    m *= (-1)
                    next if column + m > 7 || column + m < 0
                    movements << [row + n, column + m]
                end
            end
            movements
        end

    end

    class Pawn < Chess_pieces
    
        def set_color (color, black = "\u265F", white = "\u2659")
            super
        end
    
        def potencial_moves(origin_square)
            movements = []
            row = origin_square.first
            column = origin_square.last

            if @color == "black" 
                movements << [row + 2, column] if row == 1
                movements << [row + 1, column] 

            elsif @color == "white"
                movements << [row - 2, column] if row == 6
                movements << [row - 1, column] 
            end
            get_take_moves(origin_square).each{|position| movements << position}

            movements
        end
        def get_take_moves(current)
            movements = []
            row = current.first
            column = current.last
            if @color == "black" 
                [1, -1].each{|n| movements << [row + 1, column + n]}
            elsif @color == "white"
                [1, -1].each{|n| movements << [row - 1, column + n]}
            end
            movements
        end

    end
    
end