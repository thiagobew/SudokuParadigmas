(load "config.lisp")
(load "dataset.lisp")
(load "sudoku.lisp")

(defun main ()
  (print (getComparatorsGrid sudokuSize))
)

(main)