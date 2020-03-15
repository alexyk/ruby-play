require "mars/rover/version"
require "mars/rover/models"

module Mars
  module Rover
    class Error < StandardError; end

    class Rover
      def initialize(direction="N", position=[0,0])
        @direction = Mars::Rover::Models::Direction.new
        @position = Mars::Rover::Models::Position.new
      end
    end
  end
end
