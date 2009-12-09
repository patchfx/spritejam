module SpriteJam
  class Viewport
    attr_reader :x, :y, :height, :width, :tile_size
    def initialize(x, y, height, width, tile_size)
      @x = x
      @y = y
      @height = height
      @width = width
      @tile_size = tile_size
    end
    
    def offset_x
      offset(width, x)
    end
    
    def offset_y
      offset(height, y)
    end
    
    def offset(dimension, position)
      dimension - (dimension - (position / tile_size))
    end
  end
end
