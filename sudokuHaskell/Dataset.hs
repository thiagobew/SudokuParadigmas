module Dataset (getComparatorsGrid) where
  import Config ( sudokuSize )
  import Debug.Trace (trace)
  row1 :: [Char]
  row2 :: [Char]
  row3 :: [Char]
  row4 :: [Char]
  row5 :: [Char]
  row6 :: [Char]
  row7 :: [Char]
  row8 :: [Char]
  row9 :: [Char]
  row1 = ".<>.|.><>|..<<|.<>.|.<>>|..>>|.><.|.>><|..<<|"
  row2 = "<<<.|><<>|>.<>|<<<.|<>>>|<.><|>>>.|<<><|>.>>|"
  row3 = "><..|><.>|>..>|><..|<>.>|<..<|<>..|<<.<|<..>|"
  row4 = ".>>.|.><<|..<<|.>>.|.<><|..>>|.<<.|.>>>|..<<|"
  row5 = "<>>.|><<<|>.<>|<><.|<<<<|<.>>|>>>.|<>><|>.><|"
  row6 = "<<..|>>.>|>..<|><..|>>.>|<..<|<>..|<<.<|<..>|"
  row7 = ".<>.|.>>>|..><|.><.|.>><|..><|.<<.|.><>|..<<|"
  row8 = "<><.|<<<<|<.>>|>>>.|<<><|<.<>|><>.|><<>|>.>>|"
  row9 = "><..|>>.>|<..<|<<..|<<.>|>..>|<<..|>>.>|<..<|"
  allRowsSize9 :: [[Char]]
  allRowsSize9 = [row1, row2, row3, row4, row5, row6, row7, row8, row9]

  takePipeOut :: [Char] -> [Char]
  takePipeOut [] = []
  takePipeOut (x:xs) = if x /= '|' then x : takePipeOut xs else takePipeOut xs

  takeAllComparatorsFromRow :: [Char] -> [[Char]]
  takeAllComparatorsFromRow [] = []
  takeAllComparatorsFromRow rawRow = take 4 row : takeAllComparatorsFromRow (drop 4 row)
                                        where
                                          row = takePipeOut rawRow

  getComparatorsGrid :: [[[Char]]]
  getComparatorsGrid = map takeAllComparatorsFromRow allRowsSize9