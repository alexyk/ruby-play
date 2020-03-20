def prepare_result
  position_str = $position.join(',')
  direction_str = DIRECTIONS[$direction_index]

  if $obstacle_result.nil?
    "#{position_str},#{direction_str}"
  else
    "#{$obstacle_result},#{position_str},#{direction_str}"
  end
end