require 'pry'

class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]    

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(string)
        index = string.strip.to_i - 1
    end
    
    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == "X" || @board[index] == "O" ? true : false
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8) ? true : false
    end
    
    def turn
        puts "Specify a number 1-9."
        pos = gets
        index = input_to_index(pos)
        if valid_move?(index) 
            move(index, current_player) 
            display_board  
        else
            turn
        end
    end

    def turn_count
        @board.count {|i| i != " "}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def won?
        x = []
        o = []
        @board.each_with_index do |token, i|
            token == "X" ? x << i : nil
            token == "O" ? o << i : nil
        end
        result = []
        WIN_COMBINATIONS.each do |comb|
            if (comb-x).empty?
                result =  comb
            elsif (comb-o).empty?
                result = comb
            end
        end
        result.length > 0 ? result : false
    end

    def full?
        @board.select {|i| i == " "}.length > 0 ? false : true
    end

    def draw?
        full? == true && won? == false ? true : false
    end

    def over?
        won? != false || draw? == true ? true : false
    end

    def winner
        if won? !=false
            @board.select {|i| i == "X"}.length > @board.select {|i| i == "O"}.length ? "X" : "O"    
        end
    end

    def play
        while over? == false
            turn
        end
        
        if won? != false
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end

# game = TicTacToe.new
# game.display_board
# binding.pry

# game = TicTacToe.new
# board = ["X", "O", "X", "O", "X", "O", "O", "X", "X"]
# game.instance_variable_set(:@board, board)

# binding.pry