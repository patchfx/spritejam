require File.dirname(__FILE__) + '/../spec_helper'

describe SpriteJam::InputManager do
  
  context "creation" do
    before(:each) do
      @input_manager = SpriteJam::InputManager.new(mock(:window))
    end
    
    it "has no stored keys" do
      @input_manager.keys.should == []
    end
    
    it "has no keys registered" do
      @input_manager.registered_keys.should == {}
    end
  end
  
  context "register input" do
    before(:each) do
      @input_manager = SpriteJam::InputManager.new(mock(:window))
      @controls = {:right => [234, 450]}
    end
    
    it "stores the input that game entities respond to" do
      @input_manager.register_keys(@controls)
      @input_manager.registered_keys.should == {:right => [234, 450]}
    end
    
    it "adds new keys that are sent to it" do
      @input_manager.register_keys(@controls)
      @input_manager.register_keys({:left_up => [321, 876]})
      @input_manager.registered_keys.should include({:right => [234, 450], :left_up => [321, 876]})
    end
  end
  
  context "running" do
    before(:each) do
      @window = mock(:window, :button_down? => '')
      @input_manager = SpriteJam::InputManager.new(@window)
      @input_manager.register_keys({:right => [213]})
      @input_manager.stub!(:keys_changed? => false)
    end
    
    it "store multiple key presses" do
      @input_manager.register_keys({:left => [258]})
      @input_manager.stub!(:button_down?).with(213).and_return(true)
      @input_manager.stub!(:button_down?).with(258).and_return(true)
      @input_manager.run
      @input_manager.keys.should == [258, 213]
    end
    
    it "checks if a registered key was pressed" do
      @window.should_receive(:button_down?).with(213)
      @input_manager.run
    end
  end
  
  context "notify" do
    it "sets the the state to changed" do
      input_manager = SpriteJam::InputManager.new(mock(:window))
      input_manager.should_receive(:changed)
      input_manager.notify
    end
    
    it "sends a message to the observers" do
      input_manager = SpriteJam::InputManager.new(mock(:window))
      input_manager.should_receive(:notify_observers).with(input_manager.keys)
      input_manager.notify
    end
  end
  
  context "notifying observers" do
    before(:each) do
      @window = mock(:window, :button_down? => true)
      @input_manager = SpriteJam::InputManager.new(@window)
      @input_manager.register_keys({:right => [213]})
    end
    
    it "checks if the input has changed" do
      @window.should_receive(:button_down?).with(213)
      @input_manager.should_receive(:notify_observers).with([213])
      @input_manager.run
    end
  end
  
  context "check key press" do
    before(:each) do
      @window = mock(:window, :button_down? => true)
      @input_manager = SpriteJam::InputManager.new(@window)
      @input_manager.register_keys({:right => [213]})
    end
    
    it "should check if the button is being pressed" do
      @window.should_receive(:button_down?).with(213).and_return(true)
      @input_manager.check_key_press(213)
    end
    
    it "adds the input to the keys that have been pressed" do
      @window.stub!(:button_down? => true)
      @input_manager.check_key_press(213)
      @input_manager.keys.should == [213]
    end
    
    it "should remove the key from the list if it is no longer being pressed" do
      @window.stub!(:button_down? => false)
      @input_manager.check_key_press(213)
      @input_manager.keys.should be_empty
    end
  end
end
