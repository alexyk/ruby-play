RSpec.describe Mars::Rover::Actors do
  describe "CommandProcessor" do
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

    describe "process movement" do
      test_cases = {
        "within grid range" => [
          ['RMMMLMM','3,2,N'],
          ['MMMRMM', '2,3,E']
        ],
        "out of bounds (N)": [
          ["MMMMMMMMMM", '0,9,S']
        ],
        "out of bounds (S)": [
          ["RRMM", '0,1,N']
        ],
        "out of bounds (E)": [
          ["RMMMMMMMMMM", '9,0,W']
        ],
        "out of bounds (W)": [
          ["LMM", '1,0,E']
        ],
      }

      test_cases.each_pair { |test_context, item|
        context "#{test_context}" do
          item.each_index { |i|
            input, expected = item[i]
            it "test case #{i+1}: #{input} -> #{expected}" do
              result = cmd_processor.process(input, config)
              expect(result).to eq expected
            end
          }
        end
      }
    end


    context "with obstacles" do
      xit "with 1 obstacle at (0,1)" do
        obstacles = config.obstacles
        
        expect(obstacles.count).to eq 0
        obstacles.add(0,1)        
        expect(obstacles.count).to eq 1

        result = cmd_processor.process('MMR', config)
        expect(result).to eq 'O,0,0,N'
      end
    end
  end
end