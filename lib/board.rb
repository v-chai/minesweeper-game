require "colorize"
require_relative "tile"
require "byebug"

class Board
    attr_reader :grid

    def initialize(size = 9)
        @size = size
        @grid = Array.new(@size) {Array.new(@size) { Tile.new } }
    end

    def render
        puts "  #{(0...@size).to_a.join(" ")}"
        @grid.each_with_index do |row, i|
            row_print = row.map{|tile| tile.face}.join(" ")
            puts "#{i} #{row_print}"
        end
    end

    def [](pos)
        x,y = pos
        @grid[x][y]
    end

    def []=(pos,val)
        x,y = pos
        @grid[x][y] = val
    end

    def flag(pos)
        self[pos].flag
    end

    def reveal(pos)
        tile = self[pos]
        if tile.bomb
            tile.face = "%"
            tile.revealed = true
        else
            check_nearby(pos)
        end
        
    end

    def get_neighbors(pos)
        # debugger
        x,y = pos
        rows = [x-1, x, x+1]
        cols = [y-1, y, y+1]
        neighbors = rows.product(cols)
        neighbors.select {|pos| valid_coords(pos) && !self[pos].revealed }
    end

    def neighbor_bombs(pos)
        get_neighbors(pos).count { |neighbor| self[neighbor].bomb }
    end

    def valid_coords(pos)
        (0..8).to_a.include?(pos[0]) && 
        (0..8).to_a.include?(pos[1])
    end

    def check_nearby(pos)
        get_neighbors(pos).each do |neighbor| 
            bombs = neighbor_bombs(neighbor)
            if bombs > 0 
                self[neighbor].face = bombs.to_s
            else
                self[neighbor].face = "_"
                self[neighbor].revealed = true
                check_nearby(neighbor)
            end
        end
    end
end