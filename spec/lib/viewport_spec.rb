require File.dirname(__FILE__) + '/../spec_helper'

describe SpriteJam::Viewport do
  context "when created" do
    before(:each) do
      @viewport = SpriteJam::Viewport.new(4,10,100,200)
    end
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
  end
end