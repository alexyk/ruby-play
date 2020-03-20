RSpec.describe MarsRoverSimple do
  it "has a version number" do
    expect(MarsRoverSimple::VERSION).not_to be nil
  end

  context "rules" do
    it "start at (0,0)" do
      expect($position).to eq [0,0]
    end

    it "initial direction is N" do
      expect(DIRECTIONS[$direction_index]).to eq "N"
    end

    it "grid is 10x10 (max_x = 9, max_y = 9)" do
      expect(GRID_LIMITS).to eq [9, 9]
    end

    it "may have obstacles" do
      expect($obstacles.count).to eq 0
      $obstacles.append([0,4])
      $obstacles.append([2,7])
      expect($obstacles.count).to eq 2
      expect($obstacles).to eq [[0,4], [2,7]]
    end
  end
end
