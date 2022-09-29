# N is the size of the 2D matrix   N*N
from time import time
from typing import List


N = 9
nSqrt = 3
# A utility function to print grid


def printGrid(grid: List[List[int]]) -> None:
    """
    Makes a good print of the grid
    """
    for row in range(N):
        for column in range(N):
            print(grid[row][column], end=" ")
        print()


def getPossibleOptions(grid: List[List[int]], row: int, col: int, comparatorsGrid: List[List[List[str]]]) -> List[int]:
    """
    Retorna todos os valores que podem ir em uma posição específica do grid
    """
    options = []
    for num in range(1, N + 1):
        if canPutValue(grid, row, col, num, comparatorsGrid):
            options.append(num)
    return options


def executeComparison(grid: List[List[int]], comparator: str, operatorType: int, row: int, col: int, num: int) -> bool:
    """
    Recebe uma posição do grid junto com um operador em formato de string e retorna o resultado da comparação
    """
    if comparator == ">":
        if operatorType == 0:
            if num > grid[row-1][col] or grid[row-1][col] == 0:
                return True
        elif operatorType == 1:
            if num > grid[row][col+1] or grid[row][col+1] == 0:
                return True
        elif operatorType == 2:
            if num > grid[row+1][col] or grid[row+1][col] == 0:
                return True
        elif operatorType == 3:
            if num > grid[row][col-1] or grid[row][col-1] == 0:
                return True
    else:
        if operatorType == 0:
            if num < grid[row-1][col] or grid[row-1][col] == 0:
                return True
        elif operatorType == 1:
            if num < grid[row][col+1] or grid[row][col+1] == 0:
                return True
        elif operatorType == 2:
            if num < grid[row+1][col] or grid[row+1][col] == 0:
                return True
        elif operatorType == 3:
            if num < grid[row][col-1] or grid[row][col-1] == 0:
                return True
    return False

# Checks whether it will be
# legal to assign num to the
# given row, col


def canPutValue(grid: List[List[int]], row: int, col: int, num: int, comparatorsGrid: List[List[List[str]]]) -> bool:
    """
    Verifica se um número pode ser colocado em uma posição sem quebrar as regras do jogo
    """
    # Checa se obedece os operadores
    comparators = comparatorsGrid[row][col]
    for operatorType in range(4):
        if comparators[operatorType] != "":
            if not executeComparison(grid, comparators[operatorType], operatorType, row, col, num):
                return False

    # Verifica se o número já não aparece na mesma coluna ou linha em outra posição
    for x in range(N):
        if grid[row][x] == num:
            return False
        if grid[x][col] == num:
            return False

    # Verifica se o número não está na sub região específica do tabuleiro
    startRow = row - row % nSqrt
    startCol = col - col % nSqrt
    for operatorType in range(nSqrt):
        for j in range(nSqrt):
            if grid[operatorType + startRow][j + startCol] == num:
                return False
    return True


def solveSudoku(comparatorsGrid: List[List[List[str]]], grid: List[List], row: int, col: int) -> bool:
    """ Takes a partially filled-in grid and attempts
    to assign values to all unassigned locations in
    such a way to meet the requirements for
    Sudoku solution (non-duplication across rows,
    columns, and boxes) */
    """
    # Verifica se chegou na ultima célula
    if (row == N - 1 and col == N):
        return True

    # Verifica se o valor de col chegou em N, o que significa que teremos que trocar de linha
    if col == N:
        row += 1
        col = 0

    # Verifica se a posição atual já foi definida anteriormente, se foi passa para o próximo
    if grid[row][col] > 0:
        return solveSudoku(comparatorsGrid, grid, row, col + 1)

    # Pega todos os valores que podem ser colocados nessa célula sem quebrar as regras do jogo
    possibleValues = getPossibleOptions(grid, row, col, comparatorsGrid)
    for num in possibleValues:
        # Coloca o num na posição que está sendo processada e toma como verdade que está correto
        grid[row][col] = num

        # Passa para processar próxima célula da grid
        if solveSudoku(comparatorsGrid, grid, row, col + 1):
            return True

        # Caso chegue aqui é porque posteriormente não foi encontrado solução com o num nessa posição, colocamos como 0 novamente
        # e passamos para o próximo valor possível
        grid[row][col] = 0

    # Caso chegue aqui é pq alguma célula testou todos os valores e nenhum atende aos requisitos
    return False


def getOperatorsGridFromString(text: str) -> List[List[List]]:
    """ Transforma uma grid de operators em uma Lista de Listas de Listas de chars
    seguindo um padrão pre estabelecido para fazer input dos valores 
    """
    emptyRow = [None for _ in range(N)]
    grid = [emptyRow.copy() for _ in range(N)]
    operators = text.split('|')
    for row in range(N):
        for column in range(N):
            index = row * N + column
            cell = []
            for operatorChar in operators[index]:
                if operatorChar == '.':
                    cell.append("")
                else:
                    cell.append(operatorChar)

            grid[row][column] = cell
    return grid


# 0 means unassigned cells
grid = [0] * N
for i in range(N):
    grid[i] = [0] * N

# comparators in clockwise order
comparatorsGridSize4 = [[["", "<", "<", ""], ["", "", "<", ">"], ["", ">", ">", ""], ["", "", ">", "<"]],
                        [[">", ">", "", ""], [">", "", "", "<"], [
                            "<", "<", "", ""], ["<", "", "", ">"]],
                        [["", "<", ">", ""], ["", "", ">", ">"], [
                            "", ">", "<", ""], ["", "", "<", "<"]],
                        [["<", ">", "", ""], ["<", "", "", "<"], [">", "<", "", ""], [">", "", "", ">"]]]

row1 = ".<>.|.><>|..<<|.<>.|.<>>|..>>|.><.|.>><|..<<|"
row2 = "<<<.|><<>|>.<>|<<<.|<>>>|<.><|>>>.|<<><|>.>>|"
row3 = "><..|><.>|>..>|><..|<>.>|<..<|<>..|<<.<|<..>|"
row4 = ".>>.|.><<|..<<|.>>.|.<><|..>>|.<<.|.>>>|..<<|"
row5 = "<>>.|><<<|>.<>|<><.|<<<<|<.>>|>>>.|<>><|>.><|"
row6 = "<<..|>>.>|>..<|><..|>>.>|<..<|<>..|<<.<|<..>|"
row7 = ".<>.|.>>>|..><|.><.|.>><|..><|.<<.|.><>|..<<|"
row8 = "<><.|<<<<|<.>>|>>>.|<<><|<.<>|><>.|><<>|>.>>|"
row9 = "><..|>>.>|<..<|<<..|<<.>|>..>|<<..|>>.>|<..<"
board99ComparatorsGrid = getOperatorsGridFromString(
    row1 + row2 + row3 + row4 + row5 + row6 + row7 + row8 + row9)

start = time()
if (solveSudoku(board99ComparatorsGrid, grid, 0, 0)):
    printGrid(grid)
else:
    print("no solution  exists ")
fim = time()
print(f'Execution time: {fim - start}')
# This code is contributed by sudhanshgupta2019a
