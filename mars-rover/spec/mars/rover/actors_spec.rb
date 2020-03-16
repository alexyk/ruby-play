RSpec.describe Mars::Rover::Actors do
  context "process normal movement" do
    cmd_processor = Mars::Rover::Actors::CommandProcessor.new()

    xit "process normal movement in range" do
      # todo
    end
  end

  context "process commands limits" do
    xit "left out of bounds" do
      # todo
    end

    xit "right out of bounds" do
      # todo
    end

    xit "bottom out of bounds" do
      # todo
    end

    xit "top out of bounds" do
      # todo
    end

    xit "obstacle case 1" do
      # todo
    end
  end

  context "process commands with obstacles" do
    it "add an obstacle" do
    
    end
  end
end

def generate_config()
  {
    "position" => @position,
    "direction" => @direction,
    "grid_limits" => @grid_limits,
    "obstacles" => obstacles
  }
end