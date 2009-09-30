module SpriteJam
  
  class Tile
    attr_accessor :code, :index, :solid
    def initialize(code, index, solid)
      @code = code
      @index = index
      @solid = solid
    end
    
    def solid?
      @solid
    end
  end
  
  class TileSet
    attr_accessor :tiles, :tile_codes
    
    def initialize(window, map)
      @tiles = Gosu::Image::load_tiles(window, map.filename, map.tile_size, map.tile_size, false)
      @map = map
      @tile_codes = load_tile_codes
    end
    
    def load_tile_codes
      tile_codes = Array.new(@map.height) do |y|
        Array.new(@map.width) do |x|
          if @map.ascii_tiles[y][x, 1]
            code = @map.ascii_tiles[y][x, 1]
            index = tile_code_for(code)
            solid = solid_tile?(code)
            Tile.new(code, index, solid)
          end
        end
      end
      tile_codes
    end
    
    def tile_code_for(index)
      index_code = nil
      tile_codes = @map.tile_codes
      tile_codes.each_with_index do |code, i|
        tile_code = code.split(',')
        if index == tile_code[0]
          index_code = i
        end
      end
      index_code
    end
    
    def solid_tile?(index)
      solid = false
      @map.tile_codes.each do |code|
        code = code.split(',')
        if index == code[0] && code[2] == '1'
          solid = true
        end    
      end
      solid
    end
  end
  
end
