(defconstant sudokuSize 4)
(defconstant nSquare 2)

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

#|
;; not sure if working, doesn't take 4 by 4 like in haskell
(defun takeAllComparatorsFromRow(row)
  (cond ((= (length row) 0) (list))
        ((= (string-ref row 0) ?|) (takeAllComparatorsFromRow (subseq row 1)))
        (t (cons (string (string-ref row 0)) (takeAllComparatorsFromRow (subseq row 1))))
  )
)
|#

;;(defun getComparatorsGrid(size)
;; (mapa (function takeAllComparatorsFromRow) (allRows size))
;; )

(defun getSudokuGrid (size)
  (let ((grid (make-array (list size size) :initial-element 0))) grid)
)

(defun getX (l pos)
  (if (null? l)
      (error "getX: list is empty")
      (if (= pos 0)
          (car l)
          (getX (cdr l) (- pos 1))))
)

(defun setX (l pos x)
  (cond ((null l) ())
        ((= pos 0) (cons x (cdr l)))
        (t (cons (car l) (setX (cdr l) (- pos 1) x))))
)

(defun getXY (l x y)
  (getX (getX l y) x)
)

(defun setXY (l x y value)
  (setX l y (setX (getX l y) x value))
)

(defun stringToList (str)
  (stringToListRecursive str 0)
)

(defun stringToListRecursive (str i)
    (if (= (length str) i)
      ()
      (cons (char str i) (stringToListRecursive str (+ i 1)))
    )
)

(defun filter (f lista)
  (if (null lista)
    ()
    (if (funcall f (first lista))
      (cons (first lista) (filter f (cdr lista)))
      (filter f (cdr lista))
    )
  )
)

(defun mapa (f lista)
  (if (null lista)
    ()
    (cons (funcall f (first lista)) (mapa f (cdr lista)))
  )
)

(defun main ()
  (print (takePipeOut row1size9))
)

(main)