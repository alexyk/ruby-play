module Mars
  module Rover
    module State
    
      class Error < StandardError; end

      class Config
        attr_reader :direction, :position, :grid_limits, :obstacles
              
        def initialize(direction="N", position_x=0, position_y=0)
          @position = Mars::Rover::Models::Position.new(position_x, position_y)
          @direction = Mars::Rover::Models::Direction.new(direction)
          @grid_limits = [9,9]
          @obstacles = []
        end
      end
     
    end
  end
end
