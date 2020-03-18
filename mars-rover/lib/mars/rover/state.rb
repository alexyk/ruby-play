module Mars
  module Rover
    module State
    
      class Error < StandardError; end

      class Config
        attr_reader :direction, :position, :grid_limits, :obstacles
              
        def initialize(direction="N", position_x=0, position_y=0)
          @position = Mars::Rover::Models::Position.new(position_x, position_y)
          @direction = Mars::Rover::Models::Direction.new(direction)
          @grid_limits = Mars::Rover::Models::GridLimits.new(10,10)
          @obstacles = []
  
          if @auto_start
            puts "  > Processing cmd '#{@cmd}'..."
            config = {
              "position" => @position,
              "direction" => @direction,
              "grid_limits" => @grid_limits,
              "obstacles" => obstacles
            }
          end
        end
         
        def add_obstacle(*params)
          @obstacles.append(Mars::Rover::Models::Position.new(*params))
        end
        
        def obstacles_to_s()
          res = []
          for item in @obstacles
            res.append("o#{res.count + 1}: #{item.to_s2}")
          end
          
          res.join(', ')
        end
      end
     
    end
  end
end
