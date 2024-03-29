import Dataset
import Config ( sudokuSize )
import Sudoku ( getSudokuGrid, solveSudoku )
import Printer (printMatrix)


main = do
  printMatrix (solveSudoku (getSudokuGrid sudokuSize) getComparatorsGrid 0 0)