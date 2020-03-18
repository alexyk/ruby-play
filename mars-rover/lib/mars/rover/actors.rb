require "mars/rover/models"

module Mars
  module Rover
    module Actors

      P_VER = 2 # (=1) Version 1 of debug output (=2) Version 2 - with ROT/MOV and symbols ->, *
      
      class Error < StandardError; end
      
      class CommandProcessor
        def process(cmd, config=nil)
          @config = config if !config.nil?
          position = config.position
          direction = config.direction
          grid_limits = config.grid_limits
          obstacles = config.obstacles
          @obstacle_result = nil

          cmd_length = cmd.length
        
          for i in 0..cmd_length-1
            ch = cmd[i,1]

            is_rotation = Mars::Rover::Models::Direction.is_rotation?(ch)
            old_position = @config.position.clone

            if is_rotation
              self._apply_rotation_behaviour(ch, direction)
            elsif ch == "M"
              self._apply_wrapping_movement_behavior(old_position, position, direction, grid_limits, obstacles)
              self._apply_obstacle_behavior(old_position, position, obstacles)              
              if ! @obstacle_result.nil?
                break
              end
            else
              DEBUG && puts("    #{P_VER == 2 ? '  ' : ''}[WARN] '#{ch}' - unknown command, skipping ...")
              raise Error, "Unknown command '#{ch}' at index = #{i}. Not a [M]ove or rotation(L,R) command"
            end
          end

          if @obstacle_result.nil?
            "#{position},#{direction}"
          else
            "#{@obstacle_result},#{position},#{direction}"
          end
        end

        def _apply_obstacle_behavior(old_position, position, obstacles)
          if obstacles.contain?(position)
            position.change(old_position.x, old_position.y)
            @obstacle_result = "O"
          end
          position
        end

        def _apply_wrapping_movement_behavior(old_position, position, direction, grid_limits, obstacles)
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

          DEBUG && puts("    #{P_VER == 2 ? '-> [MOV]' : '[Move] '} #{old_position.to_s2} -> #{position.to_s2}")
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
