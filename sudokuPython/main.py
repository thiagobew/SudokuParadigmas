# N is the size of the 2D matrix   N*N
N = 4
nSqrt = 2
# A utility function to print grid


def printing(arr):
    for i in range(N):
        for j in range(N):
            print(arr[i][j], end=" ")
        print()

def compare(grid, comparator, case, row, col, num):
  if comparator == ">":
    if case == 0:
      if num > grid[row-1][col] or grid[row-1][col] == 0:
        return True
    elif case == 1:
      if num > grid[row][col+1] or grid[row][col+1] == 0:
        return True
    elif case == 2:
      if num > grid[row+1][col] or grid[row+1][col] == 0:
        return True
    elif case == 3:
      if num > grid[row][col-1] or grid[row][col-1] == 0:
        return True
  else:
    if case == 0:
      if num < grid[row-1][col] or grid[row-1][col] == 0:
        return True
    elif case == 1:
      if num < grid[row][col+1] or grid[row][col+1] == 0:
        return True
    elif case == 2:
      if num < grid[row+1][col] or grid[row+1][col] == 0:
        return True
    elif case == 3:
      if num < grid[row][col-1] or grid[row][col-1] == 0:
        return True
  return False

# Checks whether it will be
# legal to assign num to the
# given row, col
def isSafe(grid, row, col, num, comparatorsGrid):

    # Checking for comparators
    comparators = comparatorsGrid[row][col]
    for i in range(4):
      if comparators[i] != "":
        if not compare(grid, comparators[i], i, row, col, num):
          return False
    
    # Check if we find the same num
    # in the similar row , we
    # return false
    # Check if we find the same num in
    # the similar column , we
    # return false
    for x in range(N):
        if grid[row][x] == num:
            return False
        if grid[x][col] == num:
            return False

    # Check if we find the same num in
    # the particular 3*3 matrix,
    # we return false
    startRow = row - row % nSqrt
    startCol = col - col % nSqrt
    for i in range(nSqrt):
        for j in range(nSqrt):
            if grid[i + startRow][j + startCol] == num:
                return False
    return True

# Takes a partially filled-in grid and attempts
# to assign values to all unassigned locations in
# such a way to meet the requirements for
# Sudoku solution (non-duplication across rows,
# columns, and boxes) */


def solveSudoku(comparatorsGrid, grid, row, col):
    # Check if we have reached the 8th
    # row and 9th column (0
    # indexed matrix) , we are
    # returning true to avoid
    # further backtracking
    if (row == N - 1 and col == N):
        return True

    # Check if column value  becomes 9 ,
    # we move to next row and
    # column start from 0
    if col == N:
        row += 1
        col = 0

    # Check if the current position of
    # the grid already contains
    # value >0, we iterate for next column
    if grid[row][col] > 0:
        return solveSudoku(comparatorsGrid, grid, row, col + 1)

    for num in range(1, N + 1):
        # Check if it is safe to place
        # the num (1-9)  in the
        # given row ,col  ->we
        # move to next column
        if isSafe(grid, row, col, num, comparatorsGrid):

            # Assigning the num in
            # the current (row,col)
            # position of the grid
            # and assuming our assigned
            # num in the position
            # is correct
            grid[row][col] = num

            # Checking for next possibility with next
            # column
            if solveSudoku(comparatorsGrid, grid, row, col + 1):
                return True

        # Removing the assigned num ,
        # since our assumption
        # was wrong , and we go for
        # next assumption with
        # diff num value
        grid[row][col] = 0
    return False

# Driver Code
def getGridFromString(string):
  grid = [None] * N
  for i in range(len(string)):
    row = i // 4
    if grid[row] == None:
      grid[row] = []

    if string[i] == ".": 
      grid[row].append("")
    else:
      grid[row].append(string[i])
  
  print(grid)
  return grid
    
# 0 means unassigned cells
grid = [0] * N
for i in range(N):
    grid[i] = [0] * N

# comparators in clockwise order
comparatorsGridSize4 = [[["", "<", "<", ""], ["", "", "<", ">"], ["", ">", ">", ""], ["", "", ">", "<"]], 
                        [[">", ">", "", ""], [">", "", "", "<"], ["<", "<", "", ""], ["<", "", "", ">"]], 
                        [["", "<", ">", ""], ["", "", ">", ">"], ["", ">", "<", ""], ["", "", "<", "<"]], 
                        [["<", ">", "", ""], ["<", "", "", "<"], [">", "<", "", ""], [">", "", "", ">"]]]

comparatorsStringSize9 = ""

if (solveSudoku(comparatorsGridSize4, grid, 0, 0)):
    printing(grid)
else:
    print("no solution  exists ")

    # This code is contributed by sudhanshgupta2019a
