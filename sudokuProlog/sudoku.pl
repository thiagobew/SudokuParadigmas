%% sudoku.pl
:- use_module(library(clpfd)).



Operators = [
    ["<<.<",_,_,_,_,_,_,_,_],
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

Empty = [
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


sudoku(Puzzle) :-
    flatten(Puzzle, Tmp), Tmp ins 1..9,
    Rows = Puzzle,
    transpose(Rows, Columns),
    blocks(Rows, Blocks),
    maplist(all_distinct, Rows),
    maplist(all_distinct, Columns),
    maplist(all_distinct, Blocks),
    maplist(label, Rows).

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