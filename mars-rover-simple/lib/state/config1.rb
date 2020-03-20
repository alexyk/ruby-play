# debug constants
DEBUG = false
P_VER = 2 # (=1)  Version 1 of debug output 
          # (=2)  Version 2 - with ROT/MOV and symbols ->, *

# constants
DIRECTIONS = ['N', 'E', 'S', 'W']
ROTATIONS = ['L', 'R']
GRID_LIMITS = [9, 9]

# global variables
$direction_index = 0
$position = [0, 0]
$obstacles = []
$obstacle_result = nil