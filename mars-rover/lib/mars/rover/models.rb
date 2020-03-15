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
            @x = Integer(params[0][0])
            @y = Integer(params[0][1])
          else
            @x = Integer(params[0])
            @y = Integer(params[1])
          end
        end

        def change_x(value)
          @x += value
        end

        def change_y(value)
          @y += value
        end

        def to_s
          "(#{@x},#{@y})"
        end
      end
      
      class Direction
        DIRECTIONS = ["N", "E", "S", "W"]

        class << self
          def is_direction(ch)
            DIRECTIONS.include?(ch)
          end
        end


        def initialize(direction="N")
          @current = DIRECTIONS.index direction.upcase
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

      class GridLimits
        attr_reader :max_x, :max_y

        def initialize(size_x, size_y)
          @max_x = size_x - 1
          @max_y = size_y - 1
        end

        def to_s
          "(maxX=#{@max_x}, maxY=#{@max_y})"
        end
      end
    end
  end
end