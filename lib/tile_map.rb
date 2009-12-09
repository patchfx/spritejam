begin
    require 'rubygems'
rescue LoadError

end
require 'gosu'
require File.dirname(__FILE__) + '/map'
require File.dirname(__FILE__) + '/tile_set'
require File.dirname(__FILE__) + '/viewport'


module SpriteJam
  
  class TileMap
    attr_reader :world_x, :world_y

    def initialize(window, map_file, viewport_x, viewport_y)
      @window = window
      @map = SpriteJam::Map.new(map_file)
      @viewport = SpriteJam::Viewport.new(viewport_x, viewport_y, @map.height, @map.width, @map.tile_size)
      @tile_set = SpriteJam::TileSet.new(@window, @map)
      @world_x = 0
      @world_y = 0
      @scroll_speed = 3
    end
    
    def solid_tile?(direction, x, y)    
      size = 1
      offset_x = collision_offset(x, @world_x)
      offset_y = collision_offset(y, @world_y)
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
    
    def scroll_x(direction)
      unless ((@world_x * @map.tile_size) + @window.width) >= world_x_boundary
        @world_x += @scroll_speed if direction == 'right'
        @world_x -= @scroll_speed if direction == 'left'
      end
    end
    
    def scroll_y(direction)
      unless (((@world_y * @map.tile_size) + @window.width) >= (@map.height * @map.tile_size))
        @world_y += @scroll_speed if direction == 'down'
        @world_y -= @scroll_speed if direction == 'up'
      end
    end
    
    def world_x_boundary
      (@map.width * @map.tile_size)
    end

    def draw
      @viewport.offset_x.times do |x|
        @viewport.offset_y.times do |y|
          tile = @tile_set.tile_codes[y + @world_y][x + @world_x].index
          if tile
            @tile_set.tiles[tile].draw((x * @map.tile_size), (y * @map.tile_size), 0, 1, 1)
          end
        end
      end
    end
  end
  
end
