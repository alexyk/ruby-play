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
              DEBUG && old_dir = direction.clone
            
              direction.rotate(ch)
              
              DEBUG && puts("    #{P_VER == 2 ? '*  [ROT]' : '[Rotate]'} #{ch}: #{old_dir.to_s} -> #{direction.to_s}")
            elsif ch == "M"
              DEBUG && old_pos = position.clone
              
              case direction.to_s
                when "N"
                  position.change_y(1)
                when "S"
                  position.change_y(-1)
                when "E"
                  position.change_x(1)
                when "W"
                  position.change_x(-1)
                else
                  raise Error, "Invalid direction '#{direction}' when trying to change position"
              end
              
              DEBUG && puts("    #{P_VER == 2 ? '-> [MOV]' : '[Move] '} #{old_pos.to_s2} -> #{position.to_s2}")
            else
              DEBUG && puts("    #{P_VER == 2 ? '  ' : ''}[WARN] '#{ch}' - unknown command, skipping ...")
            end
          }

          "#{position},#{direction}"
        end
      end
    end
  end
end
