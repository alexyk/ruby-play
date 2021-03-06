RSpec.describe Mars::Rover::State do
  config = nil
  
  before(:all) do
    config = Mars::Rover::State::Config.new()
  end
  
  after(:all) do
    config = nil
  end
  
  context "Config" do
    # TODO: Improve naming
    context "initial values" do
      it "inits with position (0,0)" do
        expect(config.position.to_s).to eq '0,0'
      end
      
      it "inits with direction 'N'" do
        expect(config.direction.to_s).to eq 'N'
      end
      
      it "inits with grid limits 10,10 (max_x = 9, max_y = 9)" do
        expect(config.grid_limits).to eq [9,9]
      end
      
      it "inits with 0 obstacles" do
        expect(config.obstacles).to eq []
      end
    end
  end
end
