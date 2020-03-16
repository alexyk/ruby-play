require "mars/rover/version"
require "mars/rover/models"
require "mars/rover/actors"

module Mars
  module Rover
    class Error < StandardError; end

    class Rover
      attr_reader :cmd, :direction, :position, :grid_limits, :obstacles

      def initialize(cmd=nil, direction="N", position_x=0, position_y=0)
        if ! check_cmd(cmd)
          return
        end

        @direction = Mars::Rover::Models::Direction.new(direction)
        @position = Mars::Rover::Models::Position.new(position_x, position_y)
        @grid_limits = Mars::Rover::Models::GridLimits.new(10,10)
        @obstacles = []

        if @auto_start
          puts "  > Processing cmd '#{@cmd}'..."
          config = {
            "position" => @position,
            "direction" => @direction,
            "grid_limits" => @grid_limits,
            "obstacles" => obstacles
          }
          
          cmd_processor = Mars::Rover::Actors::CommandProcessor.new()
          result = cmd_processor.process(@cmd, config)
          puts "  > Result: #{result}"
        end
      end

      def add_obstacle(*params)
        @obstacles.append(Mars::Rover::Models::Position.new(*params))
      end

      def to_s
        res = '[Mars Rover] '
        res += "dir: '#{@direction}', "
        res += "position: #{@position.to_s2}, "
        res += "limits: #{@grid_limits.to_s}, "
        res += "cmd: '#{@cmd}', "

        n = 1
        len = @obstacles.count
        for item in @obstacles
          res += "o#{n}: #{item.to_s2}"
          n += 1
          res += ", " if n <= len
        end

        res
      end

      def check_cmd(cmd)
        if cmd.nil?
          puts
          puts "First command line argument to bin/start is obligatory. Example: 'RMMMLLM'"
          print_help
          return false
        end

        if ["help", "-h", "--help", '?', "/?"].include? cmd
          print_help
          return false
        end

        @auto_start = (cmd.include? 'auto:') 
        @cmd = cmd.sub('auto:', "")


        return true
      end

      def print_help
        puts
        puts "Usage:"
        puts "    bin/start <cmd> [start-direction] [start-x] [start-y]"
        puts "where:"
        puts "    cmd               obligatory - a command string (example: 'RMMLLM' - rotate [R]ight, [M]ove etc.)"
        puts "    start-direction   optional - one of 'N', 'S', 'W' or 'E' (default is 'N')"
        puts "    start-x           optional - start x position (default is 0"
        puts "    start-y           optional - start y position (default is 0"
        puts
      end
    end
  end
end
