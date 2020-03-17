require "mars/rover/version"
require "mars/rover/models"
require "mars/rover/actors"

module Mars
  module Rover
    DEBUG = false || ((ARGV[0] || ['']).include?('debug:'))
    class Error < StandardError; end

    class Rover
      attr_reader :cmd, :direction, :position, :grid_limits, :obstacles

      def initialize(cmd=nil, direction="N", position_x=0, position_y=0)
        @stop_at_start = 'start:' # used for testing and/or debug of initial
                                  # state without processing command input
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
        res = "[Mars Rover, version #{VERSION}] "
        details = [
          "command: '#{@cmd}'",
          "direction: '#{@direction}'",
          "position: #{@position.to_s2}",
          "limits: #{@grid_limits.to_s}"
        ]
        
        if @obstacles.count > 0
          details.append(obstacles_to_s())
        end
        res += details.join(', ')

        res
      end
      
      def obstacles_to_s()
        res = []
        for item in @obstacles
          res.append("o#{res.count + 1}: #{item.to_s2}")
        end
        res.join(', ')
      end

      def check_cmd(cmd)
        if cmd.nil?
          puts
          puts "First command line argument to 'bin/start' is obligatory. Example: 'RMMMLLM'"
          puts "For more details - please refer to usage summary below."
          print_help
          return false
        end

        if ["help", "-h", "--help", '?', "/?"].include? cmd
          print_help
          return false
        end
        
        @auto_start = (!cmd.include? @stop_at_start) 
        @auto_start && cmd = cmd.sub(@stop_at_start, "")
        if cmd.include?("debug:")
          cmd = cmd.sub('debug:', "")
        end
        @cmd = cmd


        return true
      end

      def print_help
        puts
        puts "Usage:"
        puts "    bin/start <cmd> [start-direction] [start-x] [start-y]"
        puts "where:"
        puts "    cmd               obligatory - a command string (example: 'RMMLLM' - rotate [R]ight, [M]ove etc.)"
        puts "                      Command could be prepended with '#{@stop_at_start}' for testing start values without"
        puts "                      processing command, or 'debug:' for turning debug on. (examples: '#{@stop_at_start}RMMM', "
        puts "                      'debug:#{@stop_at_start}LMMM', 'debug:#{@stop_at_start}LMMM' etc."
        puts "    start-direction   optional - one of 'N', 'S', 'W' or 'E' (default is 'N')"
        puts "    start-x           optional - start x position (default is 0"
        puts "    start-y           optional - start y position (default is 0"
        puts
      end
    end
  end
end
