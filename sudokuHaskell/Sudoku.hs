module Sudoku where
import Config

getXY :: Maybe [[a]] -> Int -> Int -> a
getXY Nothing _ _ = error "getXY: Nothing"
getXY (Just grid) x y = (grid !! y) !! x

setXY :: Maybe [[a]] -> Int -> Int -> a -> Maybe [[a]]
setXY Nothing _ _ _ = error "setXY: Nothing"
setXY (Just grid) x y val = Just (take y grid ++ [take x (grid !! y) ++ [val] ++ drop (x+1) (grid !! y)] ++ drop (y+1) grid)

getSudokuGrid :: Int -> Maybe [[Int]]
getSudokuGrid sudokuSize = Just (replicate sudokuSize (replicate sudokuSize 0))

getRow :: Maybe [[Int]] -> Int -> Int -> [Int]
getRow Nothing _ _ = []
getRow (Just grid) x y = grid !! x

getCol :: Maybe [[Int]] -> Int -> Int -> [Int]
getCol Nothing _ _ = []
getCol (Just grid) x y = map (!! y) grid

getSquare :: Maybe [[a]] -> Int -> Int -> Int -> [a]
getSquare Nothing _ _ _ = []
getSquare (Just grid) x y sudokuSize = [getXY (Just grid) (x + i) (y + j) | i <- [0..sudokuSize-1], j <- [0..sudokuSize-1]]

getPossibleOptions :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> [Int]
getPossibleOptions sudokuGrid sudokuGridChars x y = [a | a <- [1..sudokuSize], notInRow a, notInCol a, notInSquare a]
    where
        notInRow a = a `notElem` getRow sudokuGrid x y
        notInCol a = a `notElem` getCol sudokuGrid x y
        notInSquare a = a `notElem` getSquare sudokuGrid x y sudokuSize

--iteratePossibleOptions :: [[Int]] -> [[[Char]]] -> Int -> Int -> [[Int]]
--iteratePossibleOptions sudokuGrid sudokuGridChars x y = [setXY sudokuGrid x y a | a <- getPossibleOptions sudokuGrid sudokuGridChars x y]

isInvalidSudoku :: Maybe [[Int]] -> [[[Char]]] -> Bool
isInvalidSudoku sudokuGrid sudokuGridChars = any (==False) [(getXY sudokuGrid x y) == 0 || (getXY sudokuGrid x y) `elem` getPossibleOptions sudokuGrid sudokuGridChars x y | x <- [1..sudokuSize], y <- [1..sudokuSize]]

solveSudoku :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> Maybe [[Int]]
solveSudoku sudokuGrid comparatorsGrid row column
  | row == (sudokuSize - 1) && column == sudokuSize = sudokuGrid
  | column == sudokuSize = solveSudoku sudokuGrid comparatorsGrid (row + 1) 0
  | getXY sudokuGrid row column > 0 = solveSudoku sudokuGrid comparatorsGrid row (column + 1)
  | isInvalidSudoku sudokuGrid comparatorsGrid = Nothing
  | otherwise =
    case solveSudoku (setXY sudokuGrid row column (head (getPossibleOptions sudokuGrid comparatorsGrid row column))) comparatorsGrid row (column + 1) of
      Nothing -> setXY sudokuGrid row column 0
      Just n -> Just n 