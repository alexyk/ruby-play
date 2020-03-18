require "mars/rover/version"
require "mars/rover/actors"
require "mars/rover/state"


module Mars
  module Rover

    DEBUG = false || ((ARGV[0] || ['']).include?('debug:'))

    class Error < StandardError; end

    class Rover
      PARAM_STOP_AT_START = 'start:' # used for testing and/or debug of initial
                                     # state without processin◊g command input
      PARAM_DEBUG = 'debug:'         # used to set debug to 'true'
      attr_reader :cmd, :config

      def initialize(cmd=nil, direction="N", position_x=0, position_y=0)
        if ! check_cmd(cmd)
          return
        end

        @config = Mars::Rover::State::Config.new(direction, position_x, position_y)

        if @auto_start
          puts "  > Processing cmd '#{@cmd}'..."
          cmd_processor = Mars::Rover::Actors::CommandProcessor.new()
          result = cmd_processor.process(@cmd, @config)
          puts "  > Result: #{result}"
        end
      end

      def to_s
        res = "[Mars Rover, version #{VERSION}] "
        details = [
          "command: '#{@cmd}'",
          "direction: '#{@config.direction}'",
          "position: #{@config.position.to_s2}",
          "limits: #{@config.grid_limits.to_s}"
        ]
        details.append(config.obstacles.to_s())
        res += details.join(', ')

        res
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

        @auto_start = true
        if (cmd.include? PARAM_STOP_AT_START) 
          @auto_start = false
          cmd = cmd.sub(PARAM_STOP_AT_START, "")
        end
        if cmd.include?(PARAM_DEBUG)
          cmd = cmd.sub(PARAM_DEBUG, "")
        end
        @cmd = cmd


        return true
      end

      def print_help
        puts
        puts "Usage:"
        puts "    bin/start <cmd> [start-direction] [start-x] [start-y]"
        puts ""
        puts "where:"
        puts "    cmd               obligatory - a command string (example: 'RMMLLM' - rotate [R]ight, [M]ove etc.)"
        puts "                      Command could be prepended with '#{PARAM_STOP_AT_START}' for testing start values without"
        puts "                      processing command, or 'debug:' for turning debug on. (examples: '#{PARAM_STOP_AT_START}RMMM', "
        puts "                      'debug:#{PARAM_STOP_AT_START}LMMM', 'debug:#{PARAM_STOP_AT_START}LMMM' etc."
        puts "    start-direction   optional - one of 'N', 'S', 'W' or 'E' (default is 'N')"
        puts "    start-x           optional - start x position (default is 0"
        puts "    start-y           optional - start y position (default is 0"
        puts
      end
    end
    
  end
end
