RSpec.describe Mars::Rover do
  it "has a version number" do
    expect(Mars::Rover::VERSION).not_to be nil
  end

  context "rules" do
    cmd = "RMMLM"
    rover = Mars::Rover::Rover.new(cmd)

    it "start at (0,0)" do
      expect(rover.position.to_s).to eq "(0,0)"
    end

    it "initial direction is N" do
      expect(rover.direction.to_s).to eq "N"
    end

    it "grid is 10x10" do
      expect(rover.grid_limits.to_s).to eq "(maxX=9, maxY=9)"
    end

    it "receives an input command" do
      expect(rover.cmd).to eq cmd
    end

    it "may have obstacles" do
      expect(rover.obstacles.count).to eq 0
      rover.add_obstacle(0,4)
      rover.add_obstacle([2,7])
      expect(rover.obstacles.count).to eq 2
      expect(rover.to_s).to include "o1: (0,4), o2: (2,7)"
    end
  end
end
