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
  ;;(print (concatenate 'string "comparator: " (write-to-string comparator) " row: " (write-to-string row) " column: " (write-to-string column) " value: " (prin1-to-string value) " type: " (write-to-string type)))
  (cond 
      ((eq comparator #\.) t)
      ((eq comparator #\>) (compareBigger grid row column value type))
      ((eq comparator #\<) (compareSmaller grid row column value type))
      (t NIL)
  )
)

(defun canFitComparators (grid comparators row column value)
  (progn
  ;;(print comparators)
  (setq compareList '())
  (loop for i from 0 to 3 do
    (setq compareList (cons (executeComparison grid row column value (getX comparators i) i) compareList))
  )
  (null (filter (lambda (x) (eq x NIL)) compareList))
  )
)

(defun getCompare (grid comparatorsGrid row column)
  (progn
  ;;(printComparators comparatorsGrid)
  (setq compareList '())
  (loop for i from 1 to sudokuSize do
    ;;(print (concatenate 'string "comparing value: " (prin1-to-string i)))
    (if (canFitComparators grid (getXY comparatorsgrid row column) row column i)
      (setq compareList (cons 'i compareList))
    )
  )
  compareList
  )
)

(defun getSquare (grid row column)
  (progn
  ;;(print "in getSquare")
  (setq squareList '())
  (loop for i from (- row (mod row nSquare)) to (- (+ (- row (mod row nSquare)) nSquare) 1) do
    (loop for j from (- column (mod column nSquare)) to (- (+ (- column (mod column nSquare)) nSquare) 1) do
      ;;(print (concatenate 'string "row: " (prin1-to-string i) " column: " (prin1-to-string j)))
      (setq squareList (cons (getXY grid i j) squareList))
    )
  )
  ;;(print squareList)
  squareList
  )
)

(defun isPossible (grid comparatorsGrid row column value)
  (if (not (null (member value (getX grid row))))
    NIL
    (if (not (null (member value (mapa (lambda (l) (getX l column)) grid))))
      NIL
      (if (not (null (member value (getSquare grid row column))))
      NIL
      (if (null (member value (getCompare grid comparatorsGrid row column)))
        NIL
        T      
      )
      )
    )
  )
)


(defun getPossibleOptions (grid comparatorsGrid row column)
  (progn
  (setq possiblesList '())
  (loop for i from 1 to sudokuSize do
    (if (isPossible grid comparatorsGrid row column i)
      ;;(print possiblesList)
      (setq possiblesList (cons i possiblesList))
    )
  )
  possiblesList
  )
)

(defun solveSudoku (grid comparatorsGrid row column)
  (printGrid grid)
  (cond ((and (= row (- 1 sudokuSize)) (= column sudokuSize)) grid)
        ((= column sudokuSize) (solveSudoku grid comparatorsGrid (+ row 1) 0))
        ((> (getXY grid row column) 0) (solveSudoku grid comparatorsGrid row (+ column 1)))
        (t (solveSudokuWithValues grid comparatorsGrid row column (getPossibleOptions grid comparatorsGrid row column)))
  )
)

(defun solveSudokuWithValues (sudokuGrid comparatorsGrid row column possibles)
  (loop for i from 0 to (- (length possibles) 1) do
    (if (= (solveSudoku (setXY sudokuGrid row column (getX possibles i)) comparatorsGrid row column) NIL)
      (setXY sudokuGrid row column 0)
      (setXY sudokuGrid row column (getX possible i))
    )
  )
)