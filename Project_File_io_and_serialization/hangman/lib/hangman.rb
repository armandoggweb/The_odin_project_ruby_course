require 'yaml'
class Hangman
    def initialize
      @secret_word = ""
      @attempts = 6
      @guessed_characters = ""
      @missed_characters = []
      Dir.chdir('/home/armando/THE_ODIN_PROJECT/again/hangman')
    end

    def game
        puts "Start!"
        load_secret_word
        puts "Do you want to load the last saved game?(y/n)"
        load_game if gets.chomp == "y"
        until win? || @attempts == 0
            show_board
            puts "Intrduce a character or press '1' if you wanto save the game "
            @attempts -= 1 unless get_choice
        end
        @attempts == 0 ? (puts "You lose!") : (puts "You win!")
    end

    protected

    def attempts
        @attempts
    end
    def secret_word
        @secret_word
    end
    def guessed_characters
        @guessed_characters
    end
    def missed_characters
        @missed_characters
    end

    private

    def get_right_words
       words = File.readlines('5desk.txt')
       right_words = []
       words.each{|word| right_words << word.chomp.downcase if word.chomp.length > 4 || word.chomp.length < 13 }
       right_words
    end

    def load_secret_word
        words = get_right_words
        @secret_word = words[rand(0..words.length-1)]
        @guessed_characters = @guessed_characters.rjust(@secret_word.length, "-")
    end

    def show_board
        puts "#{@secret_word}"
        puts "#{@attempts} attempts left"
        puts "Guessed:  #{@guessed_characters}"
        puts "Missed:   #{@missed_characters.join(", ")}"
    end

    def get_choice (chosen_char = gets.chomp)
        match = false
        if chosen_char == "1"
            save_game
            match = true
        elsif @secret_word.include?(chosen_char)
            index = 0
            @secret_word.each_char do |char|
                if char == chosen_char
                    @guessed_characters[index] = char 
                    match = true
                end
                index += 1
            end
        else
            @missed_characters << chosen_char
        end
        match
    end

    def win?
        return true if @secret_word.eql?(@guessed_characters)
        false
    end
    
    def save_game
        Dir.mkdir('saves') unless Dir.exist?('saves')

        File.open("saves/saved_game.yaml", 'w') do |file|
            file.puts(YAML::dump(self))
        end
    end
    def load_game
        data = YAML::load(File.read("saves/saved_game.yaml"))
        @secret_word = data.secret_word
        @guessed_characters = data.guessed_characters
        @missed_characters = data.missed_characters
        @attempts = data.attempts
    end

end

juego = Hangman.new

juego.game

