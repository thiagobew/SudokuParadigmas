module Sudoku where
import Config
import Control.Monad.Writer (runWriter, Writer)
import Data.Maybe (fromMaybe)
import Debug.Trace (trace)

getXY :: Show a => Maybe [[a]] -> Int -> Int -> a
getXY Nothing _ _ = error "getXY: Nothing"
getXY (Just grid) x y = trace ("getXY: " ++ show x ++ " " ++ show y ++ " " ++ show ((grid !! x )!! y)) $ grid !! x !! y
-- getXY (Just grid) x y = grid !! x !! y

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

getSquare :: Show a => Maybe [[a]] -> Int -> Int -> Int -> [a]
getSquare Nothing _ _ _ = []
getSquare (Just grid) x y sudokuSize = [getXY (Just grid) (x + i) (y + j) | i <- [0..sudokuSize-1], j <- [0..sudokuSize-1]]

getPossibleOptions :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> [Int]
getPossibleOptions sudokuGrid sudokuGridChars x y = [a | a <- [1..sudokuSize], notInRow a, notInCol a, notInSquare a]
    where
        notInRow a = a `notElem` getRow sudokuGrid x y
        notInCol a = a `notElem` getCol sudokuGrid x y
        notInSquare a = a `notElem` getSquare sudokuGrid x y sudokuSize

isInvalidSudoku :: Maybe [[Int]] -> [[[Char]]] -> Bool
isInvalidSudoku sudokuGrid sudokuGridChars = False `elem` [getXY sudokuGrid x y == 0 || getXY sudokuGrid x y `elem` getPossibleOptions sudokuGrid sudokuGridChars x y | x <- [0..sudokuSize-1], y <- [0..sudokuSize-1]]

solveSudoku :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> Maybe [[Int]]
solveSudoku sudokuGrid comparatorsGrid row column = do
  -- Verifica se chegou na ultima célula, retorna o tabuleiro
  if row == (sudokuSize - 1) && column == sudokuSize then sudokuGrid
  -- Verifica se chegou no final de uma linha, se sim passa para a próxima
  else if column == sudokuSize then solveSudoku sudokuGrid comparatorsGrid (row + 1) 0
  -- Verifica se o valor da célula atual já foi definido, se foi passa para a próxima célula
  else if getXY sudokuGrid row column > 0 then solveSudoku sudokuGrid comparatorsGrid row (column + 1)
  -- else if isInvalidSudoku sudokuGrid comparatorsGrid then Nothing
  -- Caso passe pelas validações, executa, para cada um dos possíveis números:
  -- -> Seta o número na célula atual e passa para a próxima célula
  -- -> Mantém o controle do retorno do fluxo que partiu da célula, se houve problema reseta a célula atual e retorna Nothing  
  else do
      -- Pega os possíveis números para a posição atual
      possibles <- Just (getPossibleOptions sudokuGrid comparatorsGrid row column)
      -- Altera o tabuleiro setando o primeiro valor
      gridSetada <- setXY sudokuGrid row column (head possibles)
      -- trace ("row: " ++ show row ++ " column: " ++ show column ++ ", setting: " ++ show (setXY sudokuGrid row column (head (getPossibleOptions sudokuGrid comparatorsGrid row column)))) (return ())
      case solveSudoku (Just gridSetada) comparatorsGrid row (column + 1) of
        Nothing -> setXY sudokuGrid row column 0
        Just n -> Just n
  