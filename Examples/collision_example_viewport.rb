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
    @image = Gosu::Image.new(window, 'player_32.png', false)
  end
  
  def draw
    @image.draw(@x,@y,0)
  end
end

class CollisionExampleWindow < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = "SpriteJam - Collision Example Viewport"
    @map = SpriteJam::TileMap.new(self, 'map2.map', 800, 600)
    @player = Player.new(self, 20, 20)
    @hud = Gosu::Image.new(self, 'hud_1.png', false)
    @coord_text = Gosu::Font.new(self, Gosu::default_font_name, 30) 
    @scroll_x = 0
    @scroll_y = 0
  end
  
  def update
    if button_down? Gosu::Button::KbRight
      @player.x += 3 unless @map.solid_tile?('right', @player.x, @player.y, 0, 0)
      # if @player.x >= 400
      #         @scroll_x += 1 unless ((@scroll_x + width) >= @map.width)
      #       end
    end
    
    if button_down? Gosu::Button::KbLeft
      @player.x -= 3 unless @map.solid_tile?('left', @player.x, @player.y, 0, 0)
    end
    
    if button_down? Gosu::Button::KbUp
      @player.y -= 3 unless @map.solid_tile?('up', @player.x, @player.y, 0, 0)
    end
    
    if button_down? Gosu::Button::KbDown
      @player.y += 3 unless @map.solid_tile?('down', @player.x, @player.y, 0, 0)
    end
  end
  
  def draw
    @coord_text.draw("#{@player.x}", 70, 525, 1, 1.0, 1.0, 0xffffffff)
    @coord_text.draw("#{@player.y}", 210, 525, 1, 1.0, 1.0, 0xffffffff)
    @map.draw(@scroll_x, 0)
    @player.draw
    @hud.draw(0,500,0)
    
  end
  
end

CollisionExampleWindow.new.show