require 'observer'

module SpriteJam
  class InputManager
    include Observable
    attr_reader :keys, :registered_keys, :previous_keys
  
    def initialize(window)
      @keys = []
      @previous_keys = []
      @registered_keys = {}
      @window = window
    end
  
    def run
      @registered_keys.each do |k,v|
        v.each do |input_event|
          check_key_press(input_event)
        end
      end
      notify unless @keys.empty?
    end
  
    def check_key_press(input)
      if @window.button_down? input
        @keys << input unless @keys.include?(input)
      else
        @keys.pop(input) if @keys.include?(input)
      end
    end
  
    def register_keys(control)
      @registered_keys.merge!(control)
    end
    
    def notify
      changed
      notify_observers(@keys)
    end
  end
end
