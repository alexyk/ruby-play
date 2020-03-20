require_relative "version"

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

def apply_obstacle_behavior(old_position)
  if $obstacles.any? { |item| $position == item }
    $position = old_position.clone
    $obstacle_result = "O"
  end
  $position
end

def apply_wrapping_movement_behavior(old_position)
  case DIRECTIONS[$direction_index]
    when "N"
      if $position[1] == GRID_LIMITS[1]
        rotate_direction_180()
      else
        $position[1] += 1
      end
    when "S"
      if $position[1] == 0
        rotate_direction_180()
      else
        $position[1] += -1
      end
    when "E"
      if $position[0] == GRID_LIMITS[0]
        rotate_direction_180()
      else
        $position[0] += 1
      end
    when "W"
      if $position[0] == 0
        rotate_direction_180()
      else
        $position[0] += -1
      end
    else
      raise Error, "Invalid direction '#{direction}' when trying to change $position"
  end

  DEBUG && puts("    #{P_VER == 2 ? '-> [MOV]' : '[Move] '} #{old_position.to_s2} -> #{$position.to_s2}")
end

def rotate_direction(cmd)
  DEBUG && old_dir = direction.clone
  cmd.each_char { |rotation_type|
    case rotation_type
      when "L"
        $direction_index = ($direction_index > 0) ? ($direction_index - 1) : DIRECTIONS.count-1
      when "R"
        $direction_index = ($direction_index < DIRECTIONS.count-1) ? ($direction_index + 1) : 0
      else
        raise StandardError, "Rotation '#{rotation_type}' is not a valid value - should be 'R' or 'L'"
    end
  }
  DEBUG && puts("    #{P_VER == 2 ? '*  [ROT]' : '[Rotate]'} #{cmd}: #{old_dir.to_s} -> #{direction.to_s}")
end

def rotate_direction_180
  rotate_direction('RR')
end