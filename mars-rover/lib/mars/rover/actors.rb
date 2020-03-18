module Mars
  module Rover
    module Actors    
      class Error < StandardError; end
      P_VER = 2 # (=1) Version 1 of debug output (=2) Version 2 - with ROT/MOV and symbols ->, *
      
      class CommandProcessor
        def process(cmd, config=nil)
          @config = config if !config.nil?
          position = config.position
          direction = config.direction
          grid_limits = config.grid_limits
          obstacles = config.obstacles

          String(cmd).each_char { |ch|
            is_rotation = Mars::Rover::Models::Direction.is_rotation?(ch)
            if is_rotation
              self._apply_rotation_behaviour(ch, direction)
            elsif ch == "M"
              self._apply_wrapping_movement_behavior(position, direction, grid_limits, obstacles)
            else
              DEBUG && puts("    #{P_VER == 2 ? '  ' : ''}[WARN] '#{ch}' - unknown command, skipping ...")
            end
          }

          "#{position},#{direction}"
        end

        def _apply_wrapping_movement_behavior(position, direction, grid_limits, obstacles)
          DEBUG && old_pos = position.clone

          case direction.to_s
            when "N"
              if position.y == grid_limits.max_y
                direction.rotate_180()
              else
                position.change_y(1)
              end
            when "S"
              if position.y == 0
                direction.rotate_180()
              else
                position.change_y(-1)
              end
            when "E"
              if position.x == grid_limits.max_x
                direction.rotate_180()
              else
                position.change_x(1)
              end
            when "W"
              if position.x == 0
                direction.rotate_180()
              else
                position.change_x(-1)
              end
            else
              raise Error, "Invalid direction '#{direction}' when trying to change position"
          end

          DEBUG && puts("    #{P_VER == 2 ? '-> [MOV]' : '[Move] '} #{old_pos.to_s2} -> #{position.to_s2}")
        end

        def _apply_rotation_behaviour(cmd, direction)
          DEBUG && old_dir = direction.clone
          direction.rotate(cmd)
          DEBUG && puts("    #{P_VER == 2 ? '*  [ROT]' : '[Rotate]'} #{cmd}: #{old_dir.to_s} -> #{direction.to_s}")
        end

      end
    end
  end
end
