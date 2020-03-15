require "mars/rover/version"

module Mars
  module Rover
    module Models
      class Error < StandardError; end

      class Position
        def initialize(*params)
          self.change(*params)
        end

        def change(*params)
          if params.count == 0
            @x = 0
            @y = 0
          elsif params.count == 1 && params[0].is_a?(Array)
            @x = params[0][0]
            @y = params[0][1]
          else
            @x = params[0]
            @y = params[1]
          end
        end

        def to_s
          "#{@x},#{@y}"
        end
      end
      
      class Direction
        DIRECTIONS = ["N", "E", "S", "W"]

        def initialize(direction="N")
          @current = DIRECTIONs.index direction
        rescue "Hi"
        end

        def rotate(direction)
          
          if direction == "L"
            @current = (@current > 0) ? (@current - 1) : DIRECTIONS.count-1
          elsif direction == "R"
            @current = (@current < DIRECTIONS.count-1) ? (@current + 1) : 0
          else
            raise Error, "Direction '#{direction}' is not a valid value - should be 'R' or 'L'"
          end
          self.to_s
        end

        def to_s
          "#{DIRECTIONS[@current]}"
        end
      end
    end
  end
end