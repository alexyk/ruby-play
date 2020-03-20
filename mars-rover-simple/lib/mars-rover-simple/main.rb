require_relative "version"
require_relative "functions"

# debug constants
DEBUG = false
P_VER = 2 # (=1) Version 1 of debug output (=2) Version 2 - with ROT/MOV and symbols ->, *

# constants
DIRECTIONS = ['N', 'E', 'S', 'W']
ROTATIONS = ['L', 'R']
GRID_LIMITS = [9, 9]

# global variables
$direction_index = 0
$position = [0, 0]
$obstacles = []
$obstacle_result = nil

# puts "Version: #{MarsRoverSimple::VERSION}"

def process_cmd(cmd)
  cmd.chars.each_with_index do |ch, i|
    is_rotation = ROTATIONS.include? ch
    old_position = $position.clone

    if is_rotation
      rotate_direction(ch)
    elsif ch == "M"
      apply_wrapping_movement_behavior(old_position)
      apply_obstacle_behavior(old_position)
      if ! $obstacle_result.nil?
        break
      end
    else
      DEBUG && puts("    #{P_VER == 2 ? '  ' : ''}[WARN] '#{ch}' - unknown command, skipping ...")
      raise StandardError, "Unknown command '#{ch}' at index = #{i}. Not a [M]ove or rotation(L,R) command"
    end
  end

  position_str = $position.join(',')
  direction_str = DIRECTIONS[$direction_index]

  if $obstacle_result.nil?
    "#{position_str},#{direction_str}"
  else
    "#{$obstacle_result},#{position_str},#{direction_str}"
  end
end