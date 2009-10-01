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
      unless @map.solid_tile?('right', @player.x, @player.y)
        @player.x += 3
        if @player.x >= 400
           @map.scroll_x('right')
        end
      end
    end
    
    if button_down? Gosu::Button::KbLeft 
      unless @map.solid_tile?('left', @player.x, @player.y)
        @player.x -= 3
        if @player.x >= 400
          @map.scroll_x('left')
        end
      end
    end
    
    if button_down? Gosu::Button::KbUp
      unless @map.solid_tile?('up', @player.x, @player.y)
        @player.y -= 3
        if @player.y >= 300
          @map.scroll_y('up')
        end
      end
    end
    
    if button_down? Gosu::Button::KbDown
      unless @map.solid_tile?('down', @player.x, @player.y)
        @player.y += 3
        if @player.y >= 300
          @map.scroll_y('down')
        end
      end
    end
  end
  
  def draw
    @coord_text.draw("#{@player.x + (@scroll_x*32)}", 70, 525, 1, 1.0, 1.0, 0xffffffff)
    @coord_text.draw("#{@player.y}", 210, 525, 1, 1.0, 1.0, 0xffffffff)
    @coord_text.draw("#{@map.world_x}", 500, 525, 1, 1.0, 1.0, 0xffffffff)
    @map.draw
    @player.draw
    @hud.draw(0,500,0)
  end
  
end

CollisionExampleWindow.new.show
