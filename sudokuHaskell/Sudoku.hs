module Sudoku where
import Config
import Data.Typeable

isInt :: (Typeable a) => a -> Bool
isInt n = typeOf n == typeRep (Proxy :: Proxy Int)

data Cell = Fixed !Int | Possible ![Int] deriving Show
type Row = [[Int]]

cellToInt :: Cell -> [Int]
cellToInt (Possible xs) = xs

getXY :: [[a]] -> Int -> Int -> a
getXY grid x y = (grid !! y) !! x

setXY :: [[a]] -> Int -> Int -> a -> [[a]]
setXY grid x y val = take y grid ++ [take x (grid !! y) ++ [val] ++ drop (x+1) (grid !! y)] ++ drop (y+1) grid

getSudokuGrid :: Int -> [[Cell]]
getSudokuGrid sudokuSize = replicate sudokuSize (replicate sudokuSize (Possible [1..sudokuSize]))

getRow :: [[Cell]] -> Int -> Int -> Row
getRow grid x y = map cellToInt (grid !! x)

getCol :: [[Cell]] -> Int -> Int -> Row
getCol grid x y = map cellToInt (map (!! y) grid)

getSquare :: [[a]] -> Int -> Int -> Int -> [a]
getSquare grid x y sudokuSize = map (\(x',y') -> getXY grid x' y') [(x',y') | x' <- [x..x+sudokuSize-1], y' <- [y..y+sudokuSize-1]]

getPossibleOptions :: [[Cell]] -> [[[Char]]] -> Int -> Int -> Cell -> Cell
getPossibleOptions sudokuGrid sudokuGridChars x y value = case value of
    Fixed n -> Fixed n
    Possible options -> Possible (filter (\n -> n `notElem` (getRow sudokuGrid x y ++ getCol sudokuGrid x y ++ getSquare sudokuGrid (x - x `mod` sudokuSize) (y - y `mod` sudokuSize) sudokuSize)) options)

getPossibleOptions2 :: [[Cell]] -> [[[Char]]] -> Int -> Int -> Cell -> Cell
getPossibleOptions2 sudokuGrid sudokuGridChars x y value = case value of
    Fixed n -> Fixed n
    Possible options -> Possible ([a | a <- options, inRow a, inCol a, inSqr a])
    where
      inRow = not . (`elem` getRow sudokuGrid x y)
      inCol = not . (`elem` getCol sudokuGrid x y)
      inSqr = not . (`elem` getSquare sudokuGrid (x - x `mod` sudokuSize) (y - y `mod` sudokuSize) sudokuSize)

iteratePossibleOptions :: Cell -> [[Cell]] -> [[[Char]]] -> Int -> Int -> [[Cell]]
iteratePossibleOptions (Fixed n) sudokuGrid sudokuGridChars x y = sudokuGrid
iteratePossibleOptions (Possible options) sudokuGrid sudokuGridChars x y = if length options == 1 then setXY sudokuGrid x y (Fixed (head options)) else sudokuGrid

solveSudoku :: [[Cell]] -> [[[Char]]] -> Int -> Int -> [[Cell]]
solveSudoku sudokuGrid comparatorsGrid row column
  | row == (sudokuSize - 1) && column == sudokuSize = sudokuGrid
  | column == sudokuSize = solveSudoku sudokuGrid comparatorsGrid (row + 1) 0
  | isInt (getXY sudokuGrid row column) = solveSudoku sudokuGrid comparatorsGrid row (column + 1)
  | otherwise = solveSudoku (iteratePossibleOptions (getXY sudokuGrid row column) sudokuGrid comparatorsGrid row column) comparatorsGrid row (column + 1)