(load "utils.lisp")
(load "config.lisp")

(defun compareBigger (grid row column value type)
  (cond 
      ((= type 0) (or (> value (getXY grid (- row 1) column)) (= (getXY grid (- 1 row) column) 0)))
      ((= type 1) (or (> value (getXY grid row (+ column 1))) (= (getXY grid row (+ column 1)) 0)))
      ((= type 2) (or (> value (getXY grid (+ row 1) column)) (= (getXY grid (+ row 1) column) 0)))
      ((= type 3) (or (> value (getXY grid row (- column 1))) (= (getXY grid row (- column 1)) 0)))
      (t ())
  )
)

(defun compareSmaller (grid row column value type)
  (cond 
      ((= type 0) (or (< value (getXY grid (- row 1) column)) (= (getXY grid (- 1 row) column) 0)))
      ((= type 1) (or (< value (getXY grid row (+ column 1))) (= (getXY grid row (+ column 1)) 0)))
      ((= type 2) (or (< value (getXY grid (+ row 1) column)) (= (getXY grid (+ row 1) column) 0)))
      ((= type 3) (or (< value (getXY grid row (- column 1))) (= (getXY grid row (- column 1)) 0)))
      (t ())
  )
)

(defun executeComparison (grid row column value comparator type)
  (cond 
      ((= comparator #\.) (true))
      ((= comparator #\>) (compareBigger grid row column value type))
      ((= comparator #\<) (compareSmaller grid row column value type))
      (t ())
  )
)

(defun )

(defun solveSudoku (grid comparatorsGrid row column )
  (if (and (= row (- 1 sudokuSize) (= column sudokuSize))
    (grid)
    (if (= column sudokuSize)
      (solveSudoku grid comparatorsGrid (+ 1 row) 0)
        (if (> (getXY grid row column) 0)
          (solveSudoku gird comparatorsGrid row (+ 1 column))
        )
    )
  )
)

(defun solveSudokuWithValues (sudokuGrid comparatorsGrid row column possibles index)
  (if (>= index (getListLength possibles)) NIL )
)