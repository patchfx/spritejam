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
    
    def width
      @map.width * @map.tile_size
    end
    
    def boundary_y
      @map.boundary_for({:coord => :y, :viewport => @viewport_y})
    end
    
    def boundary_x
      @map.boundary_for({:coord => :x, :viewport => @viewport_x})
    end
    
    def solid_tile?(direction, x, y, screen_x, screen_y)    
      size = 1
      offset_x = collision_offset(x, screen_x)
      offset_y = collision_offset(y, screen_y)
      return collision_right(offset_y, offset_x, size) if direction == 'right'
      return collision_left(offset_y, offset_x, size) if direction == 'left'
      return collision_up(offset_y, offset_x, size) if direction == 'up'
      return collision_down(offset_y, offset_x, size) if direction == 'down'
      
      false
    end
    
    def collision_right(y, x, size)
      if @tile_set.tile_codes[y + size][x + size].solid?
        return true
      elsif @tile_set.tile_codes[y][x + size].solid?
        return true
      end
      false
    end
    
    def collision_left(y, x, size)
      if @tile_set.tile_codes[y + size][x].solid?
        return true
      elsif @tile_set.tile_codes[y][x].solid?
        return true
      end
      false
    end
    
    def collision_up(y, x, size)
      if @tile_set.tile_codes[y][x + size].solid? 
        return true
      elsif @tile_set.tile_codes[y][x].solid?
        return true
      end
      false
    end
    
    def collision_down(y, x, size)
      if @tile_set.tile_codes[y + size][x + size].solid? 
        return true
      elsif @tile_set.tile_codes[y + size][x].solid?
        return true
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
