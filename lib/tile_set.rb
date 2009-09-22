module SpriteJam
  
  class Tile
    attr_accessor :code, :index, :solid, :x, :y
    def initialize(code, index, solid, x, y)
      @code = code
      @index = index
      @solid = solid
      @x = x
      @y = y
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
            Tile.new(code, index, solid, (x * @map.tile_size), (y * @map.tile_size))
          end
        end
      end
      tile_codes
    end
    
    def tile_code_for(index)
      @map.tile_codes.each_with_index do |code, i|
        code = code.split(',')
        if index == code[0]
          return i
        else
          return nil
        end
      end
    end
    
    def solid_tile?(index)
      @map.tile_codes.each do |code|
        code = code.split(',')
        if index == code[0] && code[2] == '1'
          return true
        else
          return false
        end    
      end
    end
    
    def tile_from_geom(x, y)
      raise @tile_codes.inspect
    end
  end
  
end