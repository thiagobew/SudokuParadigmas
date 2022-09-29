module List where 
  size :: [a] -> Int
  size xs = case xs of
    [] -> 0
    (x:xs) -> 1 + size xs

  getXY :: [[a]] -> Int -> Int -> a
  getXY [] _ _ = error "getXY: empty list"
  getXY xs x y = (xs !! x) !! y

  setXY :: [[a]] -> Int -> Int -> a -> [[a]]
  setXY [] _ _ _ = error "setXY: empty list"
  setXY xs x y v = take x xs ++ [take y (xs !! x) ++ [v] ++ drop (y+1) (xs !! x)] ++ drop (x+1) xs

  createList :: Int -> a -> [a]
  createList 0 _ = []
  createList n valueToFill = valueToFill : createList (n-1) valueToFill
