RSpec.describe Mars::Rover::Actors do
  describe "CommandProcessor" do
    config = nil
    cmd_processor = nil

    before(:each) do
      cmd_processor = Mars::Rover::Actors::CommandProcessor.new()
      config = Mars::Rover::State::Config.new()
    end
    
    after(:each) do
      cmd_processor = nil
      config = nil
    end

    context "process movement" do
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


    context "process movement with obstacles" do
      error_actors = Mars::Rover::Actors::Error
      error_models = Mars::Rover::Models::Error


      test_cases = [
        ['MMR',[0,1],'O,0,0,N'],
        ['MMMMMMMMMRR',[0,9],'O,0,8,N'],
        ['MMMMMMMMMRMMMMMMMMMM',[9,9],'O,8,9,E'],
        ['WMMM',[1,0],'throws an error', [error_actors, "Unknown command 'W' at index = 0. Not a [M]ove or rotation(L,R) command"]],
        ['WMMM',[],'throws an error', [error_actors, "Unknown command 'W' at index = 0. Not a [M]ove or rotation(L,R) command"]],
      ]

      test_cases.each_index { |i|
        input, obstacle, expected, error = test_cases[i]

        it "obstacle at (#{obstacle.to_s})     cmd: #{input} -> expected: #{expected}" do
          obstacles = config.obstacles

          if error.nil?
            expect(obstacles.count).to eq 0
            obstacles.append(obstacle)
            expect(obstacles.count).to eq 1
    
            result = cmd_processor.process(input, config)
            expect(result).to eq expected
          else
            expect {
              cmd_processor.process(input, config)
              obstacles.append(obstacle)
            }.to raise_error(error[0], error[1])
          end
        end
      }
    end
  end
end