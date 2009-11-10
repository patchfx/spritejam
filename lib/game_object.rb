module SpriteJam
  class GameObject
    attr_accessor :x, :y, :angle, :image, :z_order
    
    def draw
      @image.draw_rot(@x, @y, @z_order, @angle)
    end
    
    def min_x
      x
    end
    
    def max_x
      return x if @image.nil?
      x + @image.width
    end
    
    def min_y
      y
    end
    
    def max_y
      return y if @image.nil?
      y + @image.height
    end
  end
  
end