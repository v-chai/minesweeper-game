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

    def reveal(pos)
        tile = self[pos]
        if tile.bomb
            tile.face = "%"
            tile.revealed = true
        else
            if check_nearby(pos) > 0
                tile.face = check_nearby(pos).to_s
                tile.revealed = true
            else
                tile.face = "_"
                tile.revealed = true
            end
        end
        
    end

    def get_neighbors(pos)
        # debugger
        x,y = pos
        rows = [x-1, x, x+1]
        cols = [y-1, y, y+1]
        neighbors = rows.product(cols)
        neighbors.select! {|pos| valid_coords(pos) && !@grid[pos].revealed }
    end

    def valid_coords(pos)
        (0..8).to_a.include?(pos[0]) && 
        (0..8).to_a.include?(pos[0])
    end

    def check_nearby(pos)
        bombs = 0
        get_neighbors(pos).each do |neighbor|
            if @grid[neighbor].bomb 
                bomb += 1
            else
                check_nearby(neighbor)
            end
        end
        bombs
    end
end