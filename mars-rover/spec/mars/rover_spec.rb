RSpec.describe Mars::Rover do
  it "has a version number" do
    expect(Mars::Rover::VERSION).not_to be nil
  end

  context "rules" do
    cmd = nil
    rover = nil

    before(:each) do
      cmd = "RMMLM"
      rover = Mars::Rover::Rover.new('start:' + cmd)
    end

    after(:each) do
      cmd = nil
      rover = nil
    end

    it "start at (0,0)" do
      expect(rover.config.position.to_s).to eq "0,0"
      expect(rover.config.position.to_s2).to eq "(0,0)"
    end

    it "initial direction is N" do
      expect(rover.config.direction.to_s).to eq "N"
    end

    it "grid is 10x10 (max_x = 9, max_y = 9)" do
      expect(rover.config.grid_limits).to eq [9, 9]
    end

    it "receives an input command" do
      expect(rover.cmd).to eq cmd
    end

    it "may have obstacles" do
      obstacles = rover.config.obstacles

      expect(obstacles.count).to eq 0
      obstacles.append([0,4])
      obstacles.append([2,7])
      expect(obstacles.count).to eq 2
      # expect(obstacles.to_s).to eq "o1: (0,4), o2: (2,7)"
      expect(obstacles).to eq [[0,4], [2,7]]
    end
  end
end
