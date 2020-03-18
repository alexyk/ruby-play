RSpec.describe Mars::Rover::Models do
  describe "Position" do
    context "initialization" do
      it "default value 0,0" do
        pos = Mars::Rover::Models::Position.new
        expect(pos.to_s).to eq('0,0')
      end

      it "with an array - Position.new([x,y])" do
        pos = Mars::Rover::Models::Position.new([1,20])
        expect(pos.to_s).to eq('1,20')
      end

      it "with two separate params - Position.new(x,y)" do
        pos = Mars::Rover::Models::Position.new(8,12)
        expect(pos.to_s).to eq('8,12')
      end
    end
    
    context "changes" do
      it "change_x in range" do
        pos = Mars::Rover::Models::Position.new(0,0)
        expect(pos.to_s).to eq('0,0')

        pos.change_x(1)
        expect(pos.to_s).to eq('1,0')

        pos.change_x(3)
        expect(pos.to_s).to eq('4,0')

        pos.change_x(-2)
        expect(pos.to_s).to eq('2,0')
      end

      it "change_y in range" do
        pos = Mars::Rover::Models::Position.new(0,0)
        expect(pos.to_s).to eq('0,0')

        pos.change_y(3)
        expect(pos.to_s).to eq('0,3')

        pos.change_y(-1)
        expect(pos.to_s).to eq('0,2')
      end

      it "change_x and change_y in succession, in range" do
        pos = Mars::Rover::Models::Position.new(0,0)
        expect(pos.to_s).to eq('0,0')

        pos.change_y(3)
        expect(pos.to_s).to eq('0,3')

        pos.change_x(5)
        expect(pos.to_s).to eq('5,3')

        pos.change_y(-2)
        expect(pos.to_s).to eq('5,1')

        pos.change_x(-3)
        expect(pos.to_s).to eq('2,1')
      end

      it "reset value (3,7 -> 1,5)" do
        pos = Mars::Rover::Models::Position.new(3,7)
        expect(pos.to_s).to eq('3,7')

        pos.change([1,5])
        expect(pos.to_s).to eq('1,5')
      end
    end
  end

  describe "Obstacles" do
    obstacles = nil

    before(:each) do
      obstacles = Mars::Rover::Models::Obstacles.new
    end
    
    after(:each) do
      obstacles = nil
    end

    it "count - initially equal to 0" do
      expect(obstacles.count).to eq 0
    end

    it "can add new items" do
      obstacles.add(0,7)
      expect(obstacles.count).to eq 1
      obstacles.add(3,2)
      expect(obstacles.count).to eq 2
      expect(obstacles.to_s).to eq "o1: (0,7), o2: (3,2)"
    end
  end

  describe "Direction" do
    dir = nil
    
    before(:each) do
      dir = Mars::Rover::Models::Direction.new()
    end

    after(:each) do
      dir = nil
    end

    it "inits with 'N'" do
      expect(dir.to_s).to eq 'N'
    end

    it "can change to left using Direction.rotate('R')" do
      dir.rotate('R')
      expect(dir.to_s).to eq "E"
      dir.rotate('R')
      expect(dir.to_s).to eq "S"
      dir.rotate('R')
      expect(dir.to_s).to eq "W"
      dir.rotate('R')
      expect(dir.to_s).to eq "N"
    end

    it "can change to right using Direction.rotate('L')" do
      dir.rotate('L')
      expect(dir.to_s).to eq "W"
      dir.rotate('L')
      expect(dir.to_s).to eq "S"
      dir.rotate('L')
      expect(dir.to_s).to eq "E"
      dir.rotate('L')
      expect(dir.to_s).to eq "N"
    end
  end

  context "GridLimits" do
    it "inits with size that translates to Position.new(x,y)" do
      grid = Mars::Rover::Models::GridLimits.new(10,10)
      expect(grid.instance_variable_get("@max_x")).to eq 9
      expect(grid.instance_variable_get("@max_y")).to eq 9
      expect(grid.to_s).to eq '(maxX=9, maxY=9)'
    end
  end
end
