RSpec.describe Mars::Rover::Models do
  context "Position initialization" do
    it "default value 0,0" do
      pos = Mars::Rover::Models::Position.new
      expect(pos.to_s).to eq('0,0')
    end

    it "with an array [x,y]" do
      pos = Mars::Rover::Models::Position.new([1,20])
      expect(pos.to_s).to eq('1,20')
    end

    it "with two separate params x and y" do
      pos = Mars::Rover::Models::Position.new(8,12)
      expect(pos.to_s).to eq('8,12')
    end
  end
  
  context "Position changes" do
    it "normal case - old 3,7, new 1,5" do
      pos = Mars::Rover::Models::Position.new(3,7)
      expect(pos.to_s).to eq('3,7')

      pos.change([1,5])
      expect(pos.to_s).to eq('1,5')
    end

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
  end
end
