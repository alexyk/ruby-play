module Mars
  module Rover
    module Actors
      class Error < StandardError; end

      class CommandProcessor
        def initialize()
        end
        
        def process(cmd, config=nil)
          @config = config if !config.nil?
          position, direction, grid_limits, obstacles = \
          config.values_at("position", "direction", "grid_limits", "obstacles")
          String(cmd).each_char { |ch|
            if Mars::Rover::Models::Direction.is_direction(ch)
              direction.rotate(ch)
            elsif ch == "M"
              case direction.to_s
              when "N"
                position.change_y(1)
              when "S"
                position.change_y(-1)
              when "E"
                position.change_x(-1)
              when "W"
                position.change_x(1)
              else
                raise Error, "Invalid direction '#{direction}' when trying to change position"
              end
            end
          }

          "#{position},#{direction}"
        end
      end
    end
  end
end