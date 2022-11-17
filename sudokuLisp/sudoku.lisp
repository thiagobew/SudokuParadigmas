(load "utils.lisp")
(load "config.lisp")

(defun compareBigger (grid row column value type)
  (cond 
      ((= type 0) (or (> value (getXY grid (- row 1) column)) (= (getXY grid (- 1 row) column) 0)))
      ((= type 1) (or (> value (getXY grid row (+ column 1))) (= (getXY grid row (+ column 1)) 0)))
      ((= type 2) (or (> value (getXY grid (+ row 1) column)) (= (getXY grid (+ row 1) column) 0)))
      ((= type 3) (or (> value (getXY grid row (- column 1))) (= (getXY grid row (- column 1)) 0)))
      (t NIL)
  )
)

(defun compareSmaller (grid row column value type)
  (cond 
      ((= type 0) (or (< value (getXY grid (- row 1) column)) (= (getXY grid (- 1 row) column) 0)))
      ((= type 1) (or (< value (getXY grid row (+ column 1))) (= (getXY grid row (+ column 1)) 0)))
      ((= type 2) (or (< value (getXY grid (+ row 1) column)) (= (getXY grid (+ row 1) column) 0)))
      ((= type 3) (or (< value (getXY grid row (- column 1))) (= (getXY grid row (- column 1)) 0)))
      (t NIL)
  )
)

(defun executeComparison (grid row column value comparator type)
  (cond 
      ((= comparator #\.) (true))
      ((= comparator #\>) (compareBigger grid row column value type))
      ((= comparator #\<) (compareSmaller grid row column value type))
      (t NIL)
  )
)

(defun isPossible (grid comparatorsGrid row column))

(defun getPossibleOptions (grid comparatorsGrid row column)
  
)

(defun solveSudoku (grid comparatorsGrid row column )
  (cond ((and (= row (- 1 sudokuSize)) (= column sudokuSize)) grid)
        ((= column sudokuSize) (solveSudoku grid comparatorsGrid (+ row 1) 0))
        ((> (getXY grid row column) 0) (solveSudoku grid comparatorsGrid row (+ column 1)))
        (t (solveSudokuWithValues grid comparatorsGrid row column (getPossibleOptions grid comparatorsGrid row column)))
  )
)

(defun solveSudokuWithValues (sudokuGrid comparatorsGrid row column possibles)
  (for i from 0 to (length possibles)
    (if (/= (solveSudoku (setXY sudokuGrid row column (getX possible i)) comparatorsGrid row column) NIL)
      (setXY sudokuGrid row column (getX possible i))
      (setXY sudokuGrid row column 0)
    )
  )
)