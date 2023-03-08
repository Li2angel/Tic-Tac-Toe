# require 'pry-byebug'
class TicTacToe
    @@game_count = 0
    @@winner = ''
    attr_accessor :game_board, :player_one, :player_two
    # This aspect of the class initializes all the instance variables need for the game
    def initialize
        puts "Player-1 enter your name:"
        @player_one = gets.chomp
        puts "Player-2 enter your name:"
        @player_two = gets.chomp

        @game_board = Array.new(3){Array.new(3,'-')}
    end

    # The instance method below displays the game board onto the screen
    def show_board
        puts "\n"
        puts " #{game_board[0][0]} | #{game_board[0][1]} | #{game_board[0][2]}"
        puts " #{game_board[1][0]} | #{game_board[1][1]} | #{game_board[1][2]}"
        puts " #{game_board[2][0]} | #{game_board[2][1]} | #{game_board[2][2]}"
        puts "\n"
    end

    # This instance method enable users to switch turn
    def switch_turn(turn)
        if turn.odd?
            choice(player_one,'O')
        else
            choice(player_two,'X')
        end
    end

    def choice(player,sign)
        puts "please enter your coordinate for an empty space"
        input = gets.chomp
        input_array = input.split('')
        coord_one = input_array[0].to_i
        coord_two = input_array[1].to_i

        until coord_one.between?(0,2) && coord_two.between?(0,2) && game_board[coord_one][coord_two] == '-'
            puts "Please enter a valid coordinate"
            puts "please enter your coordinate for an empty space"
            input = gets.chomp
            input_array = input.split('')
            coord_one = input_array[0].to_i
            coord_two = input_array[1].to_i
            show_board
            puts "\n"  
        end
        add_to_board(coord_one,coord_two,sign)
    end

    def add_to_board(coord_one,coord_two,sign)
        @game_board[coord_one][coord_two] = sign
        @@game_count += 1
    end

    # Check for 3 across
    def three_across
        @game_board.each do |i|
            if i.all? {|j| j == 'X'}
            @@winner = 'X'
            @@game_count = 9
            elsif i.all? {|j| j == 'O'}
            @@winner = 'O'
            @@game_count = 9
            else
                nil
            end
        end
    end

    # Check for 3 down
    def three_down
        flat = @game_board.flatten
        flat.each_with_index do |value, index|
            unless index > 2
                if(value == 'X' && flat[index+3]=='X' && flat[index+6]=='X')
                    @@winner = 'X'
                    @@game_count = 9
                elsif(value == 'O' && flat[index+3]=='O' && flat[index+6]=='O')
                    @@winner = 'O'
                    @@game_count = 9
                else
                    nil
                end
            else
                nil
            end
        end
    end

    # Check diagonal for 3 equal input
    def diagonal_check
        center_value = @game_board[1][1]
        if center_value == 'X' || center_value == 'O'
            if @game_board[0][0] == center_value && @game_board[2][2] == center_value
                @@winner = center_value
                @@game_count = 9
            elsif @game_board[0][2] == center_value && @game_board[2][0] == center_value
                @@winner = center_value
                @@game_count = 9
            else
                nil
            end
        end
    end

    # Final Result
    def display_score(sign)
        case sign
        when 'X'
            puts "#{player_one} wins the game"
        when 'O'
            puts "#{player_two} wins the game"
        else
            puts "It's a tie"
        end
    end

    def play_game
        puts "\n"
        show_board
        puts "\n"
        until @@game_count >= 9 do
            switch_turn(@@game_count)
            three_across
            three_down
            diagonal_check
            show_board
            puts "\n"
        end
        display_score(@@winner)
        play_again
    end

    def play_again
        puts "Would you like to play again? press [y/n]"
        answer = gets.chomp
        unless answer == ('n'||'N' )
            @game_board = Array.new(3){Array.new(3,'-')}
            @@winner = ''
            @@game_count = 0
            play_game
        end
        
    end
end

game = TicTacToe.new
game.play_game
