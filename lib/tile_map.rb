begin
    require 'rubygems'
rescue LoadError

end
require 'gosu'
require File.dirname(__FILE__) + '/map'
require File.dirname(__FILE__) + '/tile_set'


module SpriteJam
  
  class TileMap
    # Can seperate the actual map stuff into a map class
    def initialize(window, map_file, viewport_x, viewport_y)
      @viewport_x = viewport_x
      @viewport_y = viewport_y
      @window = window
      @map = SpriteJam::Map.new(map_file)
      @tile_set = SpriteJam::TileSet.new(@window, @map)
    end
    
    def boundary_y
      @map.boundary_for({:coord => :y, :viewport => @viewport_y})
    end
    
    def boundary_x
      @map.boundary_for({:coord => :x, :viewport => @viewport_x})
    end
    
    def solid_tile?(direction, x, y, screen_x, screen_y)
      offset_y = collision_offset(y, screen_y)
      offset_x = collision_offset(x, screen_x)
      
      if direction == 'right'
        return @tile_set.tile_codes[offset_y][offset_x + 1].solid?
      end
      
      if direction == 'left'
        return @tile_set.tile_codes[offset_y][offset_x - 1].solid?
      end
      
      if direction == 'up'
        return @tile_set.tile_codes[offset_y][offset_x].solid?
      end
      
      if direction == 'down'
        return @tile_set.tile_codes[offset_y + 1][offset_x].solid?
      end
      false
    end
    
    def collision_offset(coord, screen_offset)
      ((coord+(screen_offset*@map.tile_size))/@map.tile_size)
    end
    
    # Work out the width and height in the context of the viewport size
    def offset_with_viewport(geom, viewport)
      geom - (geom - (viewport / @map.tile_size))
    end

    def draw(screen_x, screen_y)
      offset_with_viewport(@map.height, @viewport_y).times do |y|
        offset_with_viewport(@map.width, @viewport_x).times do |x|
          tile = @tile_set.tile_codes[y + screen_y][x + screen_x].index
          if tile
            @tile_set.tiles[tile].draw((x * @map.tile_size), (y * @map.tile_size), 0, 1, 1)
          end
        end
      end
    end
  end
  
end
