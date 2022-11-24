%% sudoku.pl
:- use_module(library(clpfd)).


Operators = [
    [".<>.",".><>","..<<",.<>.,".<>>","..>>",".><.",".>><","..<<"],
    ["<<<.","><<>",">.<>","<<<.","<>>>","<.><",">>>.","<<><",">.>>"],
    ["><..","><.>",">..>","><..","<>.>","<..<","<>..","<<.<","<..>"],
    [".>>.",".><<","..<<",".>>.",".<><","..>>",".<<.",".>>>","..<<"],
    ["<>>.","><<<",">.<>","<><.","<<<<","<.>>",">>>.","<>><",">.><"],
    ["<<..",">>.>",">..<","><..",">>.>","<..<","<>..","<<.<","<..>"],
    [".<>.",".>>>","..><",".><.",".>><","..><",".<<.",".><>","..<<"],
    ["<><.","<<<<","<.>>",">>>.","<<><","<.<>","><>.","><<>",">.>>"],
    ["><..",">>.>","<..<","<<..","<<.>",">..>","<<..",">>.>","<..<"]
].

Puzzle = [
    [_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_]
].


sudoku() :-
    flatten(Puzzle, Tmp), Tmp ins 1..9,
    Rows = Puzzle,
    transpose(Rows, Columns),
    blocks(Rows, Blocks),
    maplist(all_distinct, Rows),
    maplist(all_distinct, Columns),
    maplist(all_distinct, Blocks),
    verifyComparators(Puzzle, Operators),
    maplist(label, Rows).

verifyComparators(Puzzle, Operators) :-
    % First Row
    compareAtPosition(Puzzle, Operators, 0, 0),
    compareAtPosition(Puzzle, Operators, 0, 1),
    compareAtPosition(Puzzle, Operators, 0, 2),
    compareAtPosition(Puzzle, Operators, 0, 3),
    compareAtPosition(Puzzle, Operators, 0, 4),
    compareAtPosition(Puzzle, Operators, 0, 5),
    compareAtPosition(Puzzle, Operators, 0, 6),
    compareAtPosition(Puzzle, Operators, 0, 7),
    compareAtPosition(Puzzle, Operators, 0, 8),
    % Second Row
    compareAtPosition(Puzzle, Operators, 1, 0),
    compareAtPosition(Puzzle, Operators, 1, 1),
    compareAtPosition(Puzzle, Operators, 1, 2),
    compareAtPosition(Puzzle, Operators, 1, 3),
    compareAtPosition(Puzzle, Operators, 1, 4),
    compareAtPosition(Puzzle, Operators, 1, 5),
    compareAtPosition(Puzzle, Operators, 1, 6),
    compareAtPosition(Puzzle, Operators, 1, 7),
    compareAtPosition(Puzzle, Operators, 1, 8),
    % Third Row
    compareAtPosition(Puzzle, Operators, 2, 0),
    compareAtPosition(Puzzle, Operators, 2, 1),
    compareAtPosition(Puzzle, Operators, 2, 2),
    compareAtPosition(Puzzle, Operators, 2, 3),
    compareAtPosition(Puzzle, Operators, 2, 4),
    compareAtPosition(Puzzle, Operators, 2, 5),
    compareAtPosition(Puzzle, Operators, 2, 6),
    compareAtPosition(Puzzle, Operators, 2, 7),
    compareAtPosition(Puzzle, Operators, 2, 8),
    % Forth Row
    compareAtPosition(Puzzle, Operators, 3, 0),
    compareAtPosition(Puzzle, Operators, 3, 1),
    compareAtPosition(Puzzle, Operators, 3, 2),
    compareAtPosition(Puzzle, Operators, 3, 3),
    compareAtPosition(Puzzle, Operators, 3, 4),
    compareAtPosition(Puzzle, Operators, 3, 5),
    compareAtPosition(Puzzle, Operators, 3, 6),
    compareAtPosition(Puzzle, Operators, 3, 7),
    compareAtPosition(Puzzle, Operators, 3, 8),
    % Quinta Linha
    compareAtPosition(Puzzle, Operators, 4, 0),
    compareAtPosition(Puzzle, Operators, 4, 1),
    compareAtPosition(Puzzle, Operators, 4, 2),
    compareAtPosition(Puzzle, Operators, 4, 3),
    compareAtPosition(Puzzle, Operators, 4, 4),
    compareAtPosition(Puzzle, Operators, 4, 5),
    compareAtPosition(Puzzle, Operators, 4, 6),
    compareAtPosition(Puzzle, Operators, 4, 7),
    compareAtPosition(Puzzle, Operators, 4, 8),
    compareAtPosition(Puzzle, Operators, 4, 9),
    % Sexta Linha
    compareAtPosition(Puzzle, Operators, 5, 0),
    compareAtPosition(Puzzle, Operators, 5, 1),
    compareAtPosition(Puzzle, Operators, 5, 2),
    compareAtPosition(Puzzle, Operators, 5, 3),
    compareAtPosition(Puzzle, Operators, 5, 4),
    compareAtPosition(Puzzle, Operators, 5, 5),
    compareAtPosition(Puzzle, Operators, 5, 6),
    compareAtPosition(Puzzle, Operators, 5, 7),
    compareAtPosition(Puzzle, Operators, 5, 8),
    compareAtPosition(Puzzle, Operators, 5, 9),
    % Sétima Linha
    compareAtPosition(Puzzle, Operators, 6, 0),
    compareAtPosition(Puzzle, Operators, 6, 1),
    compareAtPosition(Puzzle, Operators, 6, 2),
    compareAtPosition(Puzzle, Operators, 6, 3),
    compareAtPosition(Puzzle, Operators, 6, 4),
    compareAtPosition(Puzzle, Operators, 6, 5),
    compareAtPosition(Puzzle, Operators, 6, 6),
    compareAtPosition(Puzzle, Operators, 6, 7),
    compareAtPosition(Puzzle, Operators, 6, 8),
    compareAtPosition(Puzzle, Operators, 6, 9),
    % Oitáva Linha
    compareAtPosition(Puzzle, Operators, 7, 0),
    compareAtPosition(Puzzle, Operators, 7, 1),
    compareAtPosition(Puzzle, Operators, 7, 2),
    compareAtPosition(Puzzle, Operators, 7, 3),
    compareAtPosition(Puzzle, Operators, 7, 4),
    compareAtPosition(Puzzle, Operators, 7, 5),
    compareAtPosition(Puzzle, Operators, 7, 6),
    compareAtPosition(Puzzle, Operators, 7, 7),
    compareAtPosition(Puzzle, Operators, 7, 8),
    compareAtPosition(Puzzle, Operators, 7, 9),
    % Nona Linha
    compareAtPosition(Puzzle, Operators, 8, 0),
    compareAtPosition(Puzzle, Operators, 8, 1),
    compareAtPosition(Puzzle, Operators, 8, 2),
    compareAtPosition(Puzzle, Operators, 8, 3),
    compareAtPosition(Puzzle, Operators, 8, 4),
    compareAtPosition(Puzzle, Operators, 8, 5),
    compareAtPosition(Puzzle, Operators, 8, 6),
    compareAtPosition(Puzzle, Operators, 8, 7),
    compareAtPosition(Puzzle, Operators, 8, 8),
    compareAtPosition(Puzzle, Operators, 8, 9).

compareAtPosition(Puzzle, Operators, RowI, ColumnI) :- 
    nth0(RowI, Operators, Row),
    nth0(ColumnI, Row, Comparators),
    nth0(0, Comparators, Up),
    nth0(1, Comparators, Right),
    nth0(2, Comparators, Down),
    nth0(3, Comparators, Left),
    compare(0, Up, Puzzle, RowI, ColumnI),
    compare(1, Right, Puzzle, RowI, ColumnI),
    compare(2, Down, Puzzle, RowI, ColumnI),
    compare(3, Left, Puzzle, RowI, ColumnI).

compare(CharType, Char, Puzzle, RowI, ColumnI) :- 
    compareBigger(CharType, Char, Puzzle, RowI, ColumnI),
    compareSmaller(CharType, Char, Puzzle, RowI, ColumnI).
    

compareBigger(CharType, Char, Puzzle, RowI, ColumnI) :-
    (
        Char == '.';
        Char == '<'
    );
    nth0(RowI, Puzzle, Row),
    nth0(ColumnI, Row, N1),
    (
        CharType =:= 0 ->
        RowUpI is RowI - 1, nth0(RowUpI, Puzzle, RowUp), 
        nth0(ColumnI, RowUp, N2),
        N1 > N2
    ;   CharType =:= 1 ->
        ColumnIRight is ColumnI + 1, nth0(ColumnIRight, Row, N2),
        N1 > N2
    ;   CharType =:= 2 ->
        RowIDown is RowI + 1, nth0(RowIDown, Puzzle, RowDown),
        nth0(ColumnI, RowDown, N2),
        N1 > N2   
    ;   CharType =:= 3 ->
        ColumnILeft is ColumnI - 1, nth0(ColumnILeft, Row, N2),
        N1 > N2   
    ).

compareSmaller(CharType, Char, Puzzle, RowI, ColumnI) :-
    (
        Char == '.';
        Char == '<'
    );
    nth0(RowI, Puzzle, Row),
    nth0(ColumnI, Row, N1),
    (
        CharType =:= 0 ->
        RowUpI is RowI - 1, nth0(RowUpI, Puzzle, RowUp), 
        nth0(ColumnI, RowUp, N2),
        N1 < N2
    ;   CharType =:= 1 ->
        ColumnIRight is ColumnI + 1, nth0(ColumnIRight, Row, N2),
        N1 < N2
    ;   CharType =:= 2 ->
        RowIDown is RowI + 1, nth0(RowIDown, Puzzle, RowDown),
        nth0(ColumnI, RowDown, N2),
        N1 < N2   
    ;   CharType =:= 3 ->
        ColumnILeft is ColumnI - 1, nth0(ColumnILeft, Row, N2),
        N1 < N2   
    ).


blocks([A,B,C,D,E,F,G,H,I], Blocks) :-
    blocks(A,B,C,Block1), blocks(D,E,F,Block2), blocks(G,H,I,Block3),
    append([Block1, Block2, Block3], Blocks).

blocks([], [], [], []).
blocks([A,B,C|Bs1],[D,E,F|Bs2],[G,H,I|Bs3], [Block|Blocks]) :-
    Block = [A,B,C,D,E,F,G,H,I],
    blocks(Bs1, Bs2, Bs3, Blocks).