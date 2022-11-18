(defun getX (l pos)
  (if (null l)
      (error "getX: list is empty")
      (if (= pos 0)
          (car l)
          (getX (cdr l) (- pos 1))))
)

(defun setX (l pos x)
  (cond ((null l) '())
        ((= pos 0) (cons x (cdr l)))
        (t (cons (car l) (setX (cdr l) (- pos 1) x))))
)

(defun getXY (l x y)
  ;;(print (concatenate 'string "GetXY: " (write-to-string x) " " (write-to-string y)))
  (getX (getX l x) y)
)

(defun setXY (l x y value)
  (setX l x (setX (getX l x) y value))
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

(defun in (value lista)
  (if (null lista)
    nil
    (if (= (car lista) value)
      t
      (in (cdr lista) value)
    )
  )
)

(defun mapa (f lista)
  (if (null lista)
    ()
    (cons (funcall f (first lista)) (mapa f (cdr lista)))
  )
)

(defun printGridRecursive (grid i)
  (if (= i sudokuSize)
    ()
    (progn
      (print (getX grid i))
      (printGridRecursive grid (+ i 1))
    )
  )
)

(defun printGrid (grid)
  (progn
    (printGridRecursive grid 0)
    grid
  )
)

(defun printComparatorsRecursive (comparators i)
  (if (= i sudokuSize)
    ()
    (progn
      (print (getX comparators i))
      (printComparatorsRecursive comparators (+ i 1))
    )
  )
)

(defun printComparators (comparators)
  (printComparatorsRecursive comparators 0)
)