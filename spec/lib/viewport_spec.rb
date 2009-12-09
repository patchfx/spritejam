require File.dirname(__FILE__) + '/../spec_helper'

describe SpriteJam::Viewport do
  before(:each) do
    @viewport = SpriteJam::Viewport.new(4,10,100,200,32)
  end
  
  context "when created" do
    it "has an x position" do
      @viewport.x.should == 4
    end
    
    it "has a y position" do
      @viewport.y.should == 10
    end
    
    it "has a width" do
      @viewport.width.should == 200
    end
    
    it "has a height" do
      @viewport.height.should == 100
    end
    
    it "has a tile size" do
      @viewport.tile_size.should == 32
    end
  end
  
  context "offset calculations" do
    it "returns an offset for the x position" do
      pending
    end
  end
end