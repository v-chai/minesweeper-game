require_relative "board"
require_relative "tile"


class Minesweeper

    def initialize(size = 9)
        @size = size
        @board = Board.new(@size)
    end


    def play
        self.take_turn until self.lose || self.win
        if win 
            puts "Congratulations! You win!"
        else
            puts "You hit a bomb! Game over!"
        end
    end

    def take_turn

    end

    def win 
        untouched = @board.flatten.select { |tile| tile.revealed == false }
        untouched.all? {|tile| tile.bomb == true }
    end

    def lose 
        @board.flatten.any? {|tile| tile.revealed == true && tile.bomb == true }
    end 


end