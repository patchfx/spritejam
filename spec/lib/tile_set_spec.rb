require File.dirname(__FILE__) + '/../spec_helper'

describe SpriteJam::TileSet do
  before(:each) do
    file_contents = "[info]\n32\ntile_1.png\n[tiles]\n@,Grass,0\n&,Lava,1\n[map]\n@@\n&&"
    File.stub!(:readlines => file_contents)
    @map = SpriteJam::Map.new('Foo')
    @window = mock(:window)
    @gosu_image = mock(:gosu_image)
    Gosu::Image.stub!(:load_tiles => @gosu_image)
    @tileset = SpriteJam::TileSet.new(@window, @map)
  end
  
  it "loads the image tileset" do
    Gosu::Image.should_receive(:load_tiles).with(@window, 'tile_1.png', 32, 32, false).and_return(mock(:image))
    SpriteJam::TileSet.new(@window, @map)
  end
  
  it "has a tiles image" do
    @tileset.tiles.should == @gosu_image
  end
  
  it "loads the tile codes" do
    tile = mock(:tile)
    SpriteJam::Tile.stub!(:new => tile)
    @tileset.load_tile_codes.should == [[tile, tile], [tile, tile]]
  end
end
