

class Tile
    attr_reader :bomb
    attr_accessor :face, :revealed, :flag

    def initialize
        @bomb = [false, false, false, false, true].sample 
        @revealed = false
        @face = "*"
        @flag = false
    end

    def flag
        @flag = true
        @face = "!"
    end
end