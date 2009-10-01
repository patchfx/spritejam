begin
    require 'rubygems'
rescue LoadError

end

require 'gosu'
require '../spritejam'

class Player
  attr_accessor :x, :y
  def initialize(window, x, y)
    @x = x
    @y = y
    @image = Gosu::Image.new(window, 'tile_1.png', false)
  end
  
  def draw
    @image.draw(@x,@y,0)
  end
end

class CollisionExampleWindow < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = "SpriteJam - Collision Example"
    @map = SpriteJam::TileMap.new(self, 'map1.map', 800, 600)
    @player = Player.new(self, 20, 20)
  end
  
  def update
    if button_down? Gosu::Button::KbRight
      @player.x += 3 unless @map.solid_tile?('right', @player.x, @player.y)
    end
    
    if button_down? Gosu::Button::KbLeft
      @player.x -= 3 unless @map.solid_tile?('left', @player.x, @player.y)
    end
    
    if button_down? Gosu::Button::KbUp
      @player.y -= 3 unless @map.solid_tile?('up', @player.x, @player.y)
    end
    
    if button_down? Gosu::Button::KbDown
      @player.y += 3 unless @map.solid_tile?('down', @player.x, @player.y)
    end
  end
  
  def draw
    @map.draw
    @player.draw
  end
  
end

CollisionExampleWindow.new.show
