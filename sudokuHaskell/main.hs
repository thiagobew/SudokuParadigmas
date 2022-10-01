import Dataset
import Config ( sudokuSize )
import Sudoku ( getSudokuGrid )


-- Testing List
main = do
  print (getSudokuGrid sudokuSize)