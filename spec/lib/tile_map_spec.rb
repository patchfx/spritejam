require File.dirname(__FILE__) + '/../spec_helper'

describe SpriteJam::TileMap do
  describe "creation" do
    before(:each) do
      SpriteJam::TileSet.stub!(:new)
    end
    
    it "loads a map file" do
      SpriteJam::Map.should_receive(:new).with('Foo').and_return(mock(:map))
      SpriteJam::TileMap.new(mock(:window), 'Foo', 300, 300)
    end
    
    it "loads a tile set" do
      window = mock(:window)
      map = mock(:map)
      SpriteJam::Map.stub!(:new).and_return(map)
      SpriteJam::TileSet.should_receive(:new).with(window, map).and_return(mock(:tileset))
      SpriteJam::TileMap.new(window, 'Foo', 300, 300)
    end
  end
end