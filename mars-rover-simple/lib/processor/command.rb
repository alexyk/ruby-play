require_relative 'prepare_result'

def process_cmd(cmd)
  cmd.chars.each_with_index do |ch, i|
    if ! apply_behaviors(ch, i)
      break
    end
  end
  prepare_result
end