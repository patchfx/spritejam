module SpriteJam
  class Viewport
    attr_reader :x, :y, :height, :width
    def initialize(x, y, height, width)
      @x = x
      @y = y
      @height = height
      @width = width
    end
  end
end
