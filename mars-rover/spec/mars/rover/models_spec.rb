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
  end
end
