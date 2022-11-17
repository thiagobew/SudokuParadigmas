(load "config.lisp")
(load "dataset.lisp")
(load "sudoku.lisp")

(defun main ()
  (printGrid (solveSudoku (getSudokuGrid) (getComparatorsGrid) 0 0))
)

(main)