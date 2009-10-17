require File.dirname(__FILE__) + '/../spec_helper'

describe SpriteJam::Map do
  context "reading the map" do
    before(:each) do
      file_contents = "[info]\n32\ntile_1.png\n[tiles]\n#,Grass,1\n[map]\n@@@@@@@\n111111"
      File.stub!(:readlines => file_contents)
      @map = SpriteJam::Map.new('Foo')
    end
    
    it "calculates the size of the content" do
      @map.contents_size.should == 8
    end
    
    it "calculates the line that the map header exists" do
      @map.index_header.should == 5
    end
    
    it "calculates the line that the info header exists" do
      @map.info_header.should == 0
    end
    
    it "calculates the line that the tiles header exists" do
      @map.tiles_header.should == 3
    end
    
    it "returns the tile codes" do
      @map.tile_codes.should == ["#,Grass,1"]
    end
    
    it "returns the tile size" do
      @map.tile_size.should == 32
    end
    
    it "returns the ascii tiles" do
      @map.ascii_tiles.should == ["@@@@@@@", "11111"]
    end
    
    it "returns the width of the map" do
      @map.width.should == 7
    end
    
    it "returns the height of the map" do
      @map.height.should == 2
    end
    
    it "returns the filename of the tiles image" do
      @map.filename.should == "tile_1.png"
    end
    
  end
end
