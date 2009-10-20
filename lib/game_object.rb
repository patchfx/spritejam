module SpriteJam
  
  class GameObject
    attr_accessor :x, :y, :angle, :image, :z_order
    def draw
      @image.draw_rot(@x, @y, @z_order, @angle)
    end
  end
  
end