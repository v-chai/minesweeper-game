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

    def get_move
        puts "Please enter the location you want to reveal by row & column (e.g., `3,4`) >>"
        move = gets.chomp 
        move = parse_move(move)
        if valid_move?(move)
            return move
        else 
            puts "Please enter a location on the board, separated by a comma"
            get_move
        end
    end

    def parse_move(move)
        move.split(",").map { |coord| coord.to_i }
    end

    def valid_move?(move)
        move.is_a?(Array) &&
        move.length == 2 &&
        move.all? { |coord| (0..8).to_a.include?(coord)}
    end

    def take_turn
        @board.render
        move = self.get_move
        @board.reveal(move)
        @board.render
    end

    def win 
        untouched = @board.grid.flatten.select { |tile| tile.revealed == false }
        untouched.all? {|tile| tile.bomb == true }
    end

    def lose 
        @board.grid.flatten.any? {|tile| tile.revealed == true && tile.bomb == true }
    end 


end

if __FILE__ == $PROGRAM_NAME
    game = Minesweeper.new
    game.play

end