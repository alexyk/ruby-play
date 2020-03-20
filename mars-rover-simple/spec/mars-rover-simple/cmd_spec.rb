RSpec.describe MarsRoverSimple do
  describe "processing commands" do
    before(:each) do
      $direction_index = 0
      $position = [0,0]
      $obstacle_result = nil
      $obstacles = []
    end

    context "free movement (no obstacles)" do
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

      test_cases.each_pair do |test_context, item|
        context "#{test_context}" do
          item.each_index { |i|
            input, expected = item[i]
            it "test case #{i+1}: #{input} -> #{expected}" do
              result = process_cmd(input)
              expect(result).to eq expected
            end
          }
        end
      end
    end

    context "movement with obstacles" do
      test_cases = [
        ['MMR',[0,1],'O,0,0,N'],
        ['MMMMMMMMMRR',[0,9],'O,0,8,N'],
        ['MMMMMMMMMRMMMMMMMMMM',[9,9],'O,8,9,E'],
        ['WMMM',[1,0],'throws an error', ["Unknown command 'W' at index = 0. Not a [M]ove or rotation(L,R) command"]],
        ['WMMM',[],'throws an error', ["Unknown command 'W' at index = 0. Not a [M]ove or rotation(L,R) command"]],
      ]

      test_cases.each_index do |i|
        input, obstacle, expected, error = test_cases[i]

        it "obstacle at (#{obstacle.to_s})     cmd: #{input} -> expected: #{expected}" do
          if error.nil?
            expect($obstacles.count).to eq 0
            $obstacles.append(obstacle)
            expect($obstacles.count).to eq 1
    
            result = process_cmd(input)
            expect(result).to eq expected
          else
            expect {
              process_cmd(input)
              $obstacles.append(obstacle)
            }.to raise_error(error[0], error[1])
          end
        end
      end
    end

  end 
end