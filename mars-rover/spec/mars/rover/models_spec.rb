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
      obstacles = []
    end
    
    after(:each) do
      obstacles = nil
    end

    it "count - initially equal to 0" do
      expect(obstacles.count).to eq 0
    end

    it "can add new items" do
      obstacles.append([0,7])
      expect(obstacles.count).to eq 1
      obstacles.append([3,2])
      expect(obstacles.count).to eq 2
      expect(obstacles).to eq [[0, 7], [3, 2]]
    end

    it "can check if contains an item" do
      obstacles.append([0,7])

      expect(obstacles.any? { |item| item == [0,0] }).to eq false
      expect(obstacles.any? { |item| item == [0,7] }).to eq true
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

    it "can change to right using Direction.rotate('R')" do
      dir.rotate('R')
      expect(dir.to_s).to eq "E"
      dir.rotate('R')
      expect(dir.to_s).to eq "S"
      dir.rotate('R')
      expect(dir.to_s).to eq "W"
      dir.rotate('R')
      expect(dir.to_s).to eq "N"
    end

    it "can change to left using Direction.rotate('L')" do
      dir.rotate('L')
      expect(dir.to_s).to eq "W"
      dir.rotate('L')
      expect(dir.to_s).to eq "S"
      dir.rotate('L')
      expect(dir.to_s).to eq "E"
      dir.rotate('L')
      expect(dir.to_s).to eq "N"
    end

    it "can rotate multiple times" do
      dir.rotate('LL')
      expect(dir.to_s).to eq "S"
      dir.rotate('RRR')
      expect(dir.to_s).to eq "E"
    end
    
    it "can rotate 180 degrees" do
      expect(dir.to_s).to eq "N"
      dir.rotate_180()
      expect(dir.to_s).to eq "S"
      
      dir.rotate('R')
      expect(dir.to_s).to eq "W"
      dir.rotate_180()
      
      dir.rotate_180()
      expect(dir.to_s).to eq "W"
      
      dir.rotate_180()
      expect(dir.to_s).to eq "E"
    end
  end
end
