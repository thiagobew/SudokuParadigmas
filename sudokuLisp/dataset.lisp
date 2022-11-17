(load "utils.lisp")
(load "config.lisp")

(defconstant row1size4 ".<>.|..<>|.<<.|..>>|")
(defconstant row2size4 "<<..|>..>|>>..|<..<|")
(defconstant row3size4 ".>>.|..<<|.<<.|..>>|")
(defconstant row4size4 "<>..|>..<|>>..|<..<|")

(defconstant row1size9 ".<>.|.><>|..<<|.<>.|.<>>|..>>|.><.|.>><|..<<|")
(defconstant row2size9 "<<<.|><<>|>.<>|<<<.|<>>>|<.><|>>>.|<<><|>.>>|")
(defconstant row3size9 "><..|><.>|>..>|><..|<>.>|<..<|<>..|<<.<|<..>|")
(defconstant row4size9 ".>>.|.><<|..<<|.>>.|.<><|..>>|.<<.|.>>>|..<<|")
(defconstant row5size9 "<>>.|><<<|>.<>|<><.|<<<<|<.>>|>>>.|<>><|>.><|")
(defconstant row6size9 "<<..|>>.>|>..<|><..|>>.>|<..<|<>..|<<.<|<..>|")
(defconstant row7size9 ".<>.|.>>>|..><|.><.|.>><|..><|.<<.|.><>|..<<|")
(defconstant row8size9 "<><.|<<<<|<.>>|>>>.|<<><|<.<>|><>.|><<>|>.>>|")
(defconstant row9size9 "><..|>>.>|<..<|<<..|<<.>|>..>|<<..|>>.>|<..<|")

(defun allRows (size)
  (cond ((= size 9) (list row1size9 row2size9 row3size9 row4size9 row5size9 row6size9 row7size9 row8size9 row9size9))
        ((= size 4) (list row1size4 row2size4 row3size4 row4size4)))
)

(defun takePipeOut (row)
  (filter (lambda (x) (not (eq x #\|))) (stringToList row))
)

(defun allRowsNoPipe (size)
  (mapa (function takePipeOut) (allRows size))
)

(defun takeAllComparatorsFromRow (row i size)
  (if (= i (* size 4))
      ()
      (cons (list (getX row i) (getX row (+ i 1)) (getX row (+ i 2)) (getX row (+ i 3))) (takeAllComparatorsFromRow row (+ i 4) size))
  )
)

(defun getComparatorsGrid ()
 (mapa (lambda (row) (takeAllComparatorsFromRow row 0 sudokuSize)) (allRowsNoPipe sudokuSize))
)

(defun get0List (size)
  (setq 0List '())
  (progn
    (loop for i from 1 to size do
      (setq 0List (cons 0 0List))
    )
  0List
  )
)

(defun getSudokuGrid ()
  (progn
  (setq grid '())
  (loop for i from 1 to sudokuSize do
    (setq grid (cons (get0list sudokuSize) grid))
  )
  grid
  )
)