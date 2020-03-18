RSpec.describe Mars::Rover::State do
  config = nil
  
  before(:all) do
    config = Mars::Rover::State::Config.new()
  end
  
  after(:all) do
    config = nil
  end
  
  it "initial data values" do
    position, direction, grid_limits, obstacles = config.instance_variables
    
    expect(config.position.to_s).to eq '0,0'
    expect(config.direction.to_s).to eq 'N'
    expect(config.grid_limits.to_s).to eq '(maxX=9, maxY=9)'
    expect(config.obstacles.to_s).to eq ""
  end
end
