require "mars/rover/version"

module Mars
  module Rover
    module Models
    
      class Error < StandardError; end

      class Position
        attr_reader :x, :y

        def initialize(*params)
          change(*params)
        end

        def equals?(obstacle)
          [x, y] == obstacle
        end

        def change(*params)
          if params.count == 0
            @x = 0
            @y = 0
          elsif params.count == 1 && params[0].is_a?(Array)
            if params[0].count == 2
              @x = Integer(params[0][0])
              @y = Integer(params[0][1])
            else
              raise Error, "Cannot create Position intstance. Two params x and y needed or an array with length 2. Current array has #{params[0].count} item(s)"
            end
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
          "#{@x},#{@y}"
        end

        def to_s2
          "(#{@x},#{@y})"
        end
      end
      
      
      class Direction
        DIRECTIONS = ["N", "E", "S", "W"]
        ROTATIONS = ["R", "L"]
        
        class << self
          def is_rotation?(ch)
            ROTATIONS.include?(ch)
          end
        end

        def initialize(direction="N")
          @current = DIRECTIONS.index direction.upcase
        end

        def rotate(rotation_commands)
          rotation_commands.each_char { |rotation_type|
            case rotation_type
              when "L"
                @current = (@current > 0) ? (@current - 1) : DIRECTIONS.count-1
              when "R"
                @current = (@current < DIRECTIONS.count-1) ? (@current + 1) : 0
              else
                raise Error, "Rotation '#{rotation_type}' is not a valid value - should be 'R' or 'L'"
            end
          }
          to_s
        end

        def rotate_180()
          rotate('RR')
        end

        def to_s
          "#{DIRECTIONS[@current]}"
        end
      end

    end
  end
end