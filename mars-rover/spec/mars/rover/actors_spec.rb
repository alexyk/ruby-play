RSpec.describe Mars::Rover::Actors do
  context "process normal movement" do
    config = nil
    cmd_processor = nil

    before(:all) do
      cmd_processor = Mars::Rover::Actors::CommandProcessor.new()
    end

    after(:all) do
      cmd_processor = nil
    end

    before(:each) do
      config = Mars::Rover::State::Config.new()
    end
    
    after(:each) do
      config = nil
    end

    it "process normal movement in range 1" do
      res = cmd_processor.process('RMMMLMM', config)
      expect(res).to eq "3,2,N"
    end
    
    it "process normal movement in range 2" do
      res = cmd_processor.process('MMMRMM', config)
      expect(res).to eq "2,3,E"
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