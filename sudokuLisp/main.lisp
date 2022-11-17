(load "config.lisp")
(load "dataset.lisp")
(load "sudoku.lisp")

(defun main ()
  (print (solveSudoku (getSudokuGrid) (getComparatorsGrid) 0 0))
)

(main)