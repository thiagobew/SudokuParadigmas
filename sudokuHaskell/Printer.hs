module Printer (printMatrix) where
import Debug.Trace (trace)

printMatrix :: [[Int]] -> [[Int]]
printMatrix (x:xs) = do
    trace (show x) $ printMatrix xs


