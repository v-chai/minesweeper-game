

class Tile
    attr_reader :bomb
    attr_accessor :face, :revealed

    def initialize
        @bomb = [false, false, false, false, true].sample 
        @revealed = false
        @face = "*"
    end
end