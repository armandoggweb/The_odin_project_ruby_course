class Mastermind

    def initialize
        @code = Array.new(4)
        @decoding_board = Array.new(10){Array.new(4,"-")}
        @key_board = Array.new(4,"-")
        @turn = 0
    end
    def set_code (role)
        if role == "g"
            @code.map!{|n| n = rand(1..6)}
        else
            puts "Introduce 4 numbers to create the hidden code: "
            @code = (gets.chomp).lstrip.split(" ")
            @code.map!{|element| element.to_i}  
        end
    end

    def show_board
        @decoding_board.each_with_index do |row, index|
            temp = row.join("|")
            index == @turn ? (puts temp.concat("  ", @key_board.join("|"))): (puts temp)
        end
        puts("------")
    end
    def set_key_pegs
        0.upto(3) do |index|
            @key_board[index] = "W" if @code.include?(@decoding_board[@turn][index])
            @key_board[index] = "B" if @code[index] == @decoding_board[@turn][index]
        end   
    end
    def comp_get_guess_code
        puts "Resolving code..."
        @turn == 0 ? temp_deco = @decoding_board[@turn] : temp_deco = @decoding_board[@turn - 1]
        @decoding_board[@turn].each_index do |index|
            if @key_board[index] == "B"
                @decoding_board[@turn][index] = temp_deco[index]
            else 
                @decoding_board[@turn][index] = rand(1..6)

            end
        end
        @decoding_board[@turn].each_index do |index|
            if @key_board[index] == "W" && @key_board.count("B") < 3
                unless (index + 1) == @decoding_board[@turn].length || @key_board[index] == "B"
                    @decoding_board[@turn][index + 1] = temp_deco[index]  
                end
            end
        end
    end
    def get_guess_code (role)
        if role == "c"
            self.comp_get_guess_code
        else
            puts "Introduce 4 numbers: "
            @decoding_board[@turn] = (gets.chomp).lstrip.split(" ")
            @decoding_board[@turn].map!{|element| element.to_i}  
        end
        @key_board.fill("-")
        self.set_key_pegs
    end
    def win?
        @key_board.count("B") == 4 ? true : false
    end

    def game
        last_round = @decoding_board.length
        puts "Do you want to be the coder or the guesser?(c/g)"
        role = gets.chomp
        self.set_code(role)
        until self.win? || @turn == last_round
            puts "start"
            self.get_guess_code(role)
            self.show_board
            @turn += 1
        end
        @turn == last_round ? (puts "You lose!") : (puts "You win!") 
    end   
end
juego = Mastermind.new
juego.game
