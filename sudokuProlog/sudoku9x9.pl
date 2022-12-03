:- use_module(library(clpfd)).

valid(A) :-
  member(A, [1, 2, 3, 4, 5, 6, 7, 8, 9]).

validate([]).
validate([H|T]) :-
  not(member(H, T)),
  validate(T).

bigger(A, B) :-
  valid(A),
  valid(B),
  A > B.

smaller(A, B) :-
  valid(A),
  valid(B),
  A < B.

biggerBigger(A, B, C) :-
  bigger(A, B),
  bigger(B, C).

biggerSmaller(A, B, C) :-
  bigger(A, B),
  smaller(B, C).

smallerBigger(A, B, C) :-
  smaller(A, B),
  bigger(B, C).

smallerSmaller(A, B, C) :-
  smaller(A, B),
  smaller(B, C).

smallerSmallerSmaller(A, B, C, D, E, F) :-
  smaller(A, B),
  smaller(C, D),
  smaller(E, F).

smallerSmallerBigger(A, B, C, D, E, F) :-
  smaller(A, B),
  smaller(C, D),
  bigger(E, F).

menorMaiorMaior(A, B, C, D, E, F) :-
  smaller(A, B),
  bigger(C, D),
  bigger(E, F).

maiorMaiorMaior(A, B, C, D, E, F) :-
  bigger(A, B),
  bigger(C, D),
  bigger(E, F).

maiorMaiorMenor(A, B, C, D, E, F) :-
  bigger(A, B),
  bigger(C, D),
  smaller(E, F).

maiorMenorMenor(A, B, C, D, E, F) :-
  bigger(A, B),
  smaller(C, D),
  smaller(E, F).

maiorMenorMaior(A, B, C, D, E, F) :-
  bigger(A, B),
  smaller(C, D),
  bigger(E, F).

menorMaiorMenor(A, B, C, D, E, F) :-
  smaller(A, B),
  bigger(C, D),
  smaller(E, F).

Solution=[
  [A1, A2, A3, A4, A5, A6, A7, A8, A9], 
  [B1, B2, B3, B4, B5, B6, B7, B8, B9], 
  [C1, C2, C3, C4, C5, C6, C7, C8, C9], 
  [D1, D2, D3, D4, D5, D6, D7, D8, D9], 
  [E1, E2, E3, E4, E5, E6, E7, E8, E9], 
  [F1, F2, F3, F4, F5, F6, F7, F8, F9],
  [G1, G2, G3, G4, G5, G6, G7, G8, G9], 
  [H1, H2, H3, H4, H5, H6, H7, H8, H9], 
  [I1, I2, I3, I4, I5, I6, I7, I8, I9]].

solve(Solution) :-
  % Problem 11 - 9x9
  Solution = [
    [A1, A2, A3, A4, A5, A6, A7, A8, A9], 
    [B1, B2, B3, B4, B5, B6, B7, B8, B9], 
    [C1, C2, C3, C4, C5, C6, C7, C8, C9], 
    [D1, D2, D3, D4, D5, D6, D7, D8, D9], 
    [E1, E2, E3, E4, E5, E6, E7, E8, E9], 
    [F1, F2, F3, F4, F5, F6, F7, F8, F9],
    [G1, G2, G3, G4, G5, G6, G7, G8, G9], 
    [H1, H2, H3, H4, H5, H6, H7, H8, H9], 
    [I1, I2, I3, I4, I5, I6, I7, I8, I9]],
  
  % Rows constraint
  maplist(all_distinct, Solution),

  % Columns constraint
  transpose(Solution, Columns),
  maplist(all_distinct, Columns),

  % Solution is presented in blocks (like the ones in sudoku), starting at the top left corner
  % Block 1
  smallerBigger(A1, A2, A3), % line 1
  smallerSmaller(B1, B2, B3), % line 2
  smallerSmaller(C1, C2, C3), % line 3
  biggerSmaller(A1, B1, C1), % column 1
  smallerSmaller(A2, B2, C2), % column 2
  smallerSmaller(A3, B3, C3), % column 3
  validate([A1, A2, A3, B1, B2, B3, C1, C2, C3]),

  % Block 2
  smallerSmaller(A4, A5, A6), % line 1
  smallerBigger(B4, B5, B6), % line 2
  smallerBigger(C4, C5, C6), % line 3
  biggerSmaller(A4, B4, C4), % column 4
  biggerBigger(A5, B5, C5), % column 5
  biggerBigger(A6, B6, C6), % column 6
  validate([A4, A5, A6, B4, B5, B6, C4, C5, C6]),


  % Block 3
  biggerBigger(A7, A8, A9), % line 1
  biggerSmaller(B7, B8, B9), % line 2
  biggerSmaller(C7, C8, C9), % line 3
  smallerBigger(A7, B7, C7), % column 7
  biggerBigger(A8, B8, C8), % column 8
  smallerBigger(A9, B9, C9), % column 9
  validate([A7, A8, A9, B7, B8, B9, C7, C8, C9]),
  
  % Block 4

  % Block 5
  
  % Block 6
  
  % Block 7
  
  % Block 8
  
  % Block 9

solve(Solution).
