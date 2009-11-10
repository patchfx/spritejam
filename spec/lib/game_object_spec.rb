require File.dirname(__FILE__) + '/../spec_helper'

describe SpriteJam::GameObject do
  context "bounding box" do
    before(:each) do
      @obj = SpriteJam::GameObject.new
      @obj.x = 100
      @obj.y = 35
    end
    
    it "returns the minimum x position" do
      @obj.min_x.should == 100
    end
    
    it "returns the maximum x position" do
      image = mock(:image, :width => 150)
      @obj.image = image
      @obj.max_x.should == 250
    end
    
    it "returns the minimum y position" do
      @obj.min_y.should == 35
    end
    
    it "returns the maximum y position" do
      image = mock(:image, :height => 120)
      @obj.image = image
      @obj.max_y.should == 155
    end
    
    it "returns the y value if there is no image" do
      @obj.image = nil
      @obj.max_y.should == 35
    end
    
    it "returns the x value if there is no image" do
      @obj.image = nil
      @obj.max_x.should == 100
    end
    
  end
end