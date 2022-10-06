import Dataset
import Config ( sudokuSize )
import Sudoku ( getSudokuGrid, solveSudoku )


-- Testing List
main = do
  print (solveSudoku (getSudokuGrid sudokuSize) getComparatorsGrid 0 0)