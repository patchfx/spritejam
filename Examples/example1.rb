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
  
  def draw
    @map.draw
  end
  
end

GameWindow.new.show
