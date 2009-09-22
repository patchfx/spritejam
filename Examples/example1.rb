begin
    require 'rubygems'
rescue LoadError

end

require 'gosu'
require '../spritejam'

class GameWindow < Gosu::Window
  
  def initialize
    super(800, 600, false)
    self.caption = "SpriteJam - Basic Map Loading"
    @map = SpriteJam::TileMap.new(self, 'map1.map', 800, 600)
    @x_pos = 0
    @y_pos = 0
  end
  
  def update
    if button_down? Gosu::Button::KbRight
      @x_pos += 1 unless @x_pos >= @map.boundary_x
    end
    
    if button_down? Gosu::Button::KbLeft
      @x_pos -= 1 unless @x_pos == 0
    end
    
    if button_down? Gosu::Button::KbUp
      @y_pos -= 1 unless @y_pos == 0
    end
    
    if button_down? Gosu::Button::KbDown
      @y_pos += 1 unless @y_pos >= @map.boundary_y
    end
  end
  
  def draw
    @map.draw(@x_pos, @y_pos) # need to divide this by 10 in the lib
  end
  
end

GameWindow.new.show