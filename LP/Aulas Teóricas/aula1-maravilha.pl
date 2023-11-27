% -------------------------------------------------------------
%                   Exercicios Padrao em Prolog
% -------------------------------------------------------------

/*
somaRec(L, N, S) e verdade se S for a soma dos elementos de L
maiores que N (versao recursiva).

?- somaRec([2, 5, 1, 6], 3, S).
S = 11.
*/

somaRec([], _, 0) :- !.

somaRec([H | T], N, S) :-
	H > N, !,
	somaRec(T, N, S1),
	S is S1 + H.

somaRec([H | T], N, S) :-
	H =< N, !,
	somaRec(T, N, S).
	
/* 
somaIt(L, N, S) e verdade se S for a soma dos elementos de L 
maiores que N (versao iterativa). Nota: tambem e recursiva.

?- somaIt([2, 5, 1, 6], 3, S).
S = 11.
*/
somaIt(L, N, S) :- 
    somaIt(L, N, S, 0). % engorda predicado

somaIt([], _, Acc, Acc).

somaIt([H | T], N, S, Ac) :-
	H > N, !,
	Ac1 is Ac + H,
	somaIt(T, N, S, Ac1).

somaIt([H | T], N, S, Ac) :-
	H =< N, !,
	somaIt(T, N, S, Ac).
	
% -------------------------------------------------------------

/*
maiorQueRec(L1, N, L2) e verdade se L2 for a lista com os 
elementos de L1 maiores que N (versao recursiva).

?- maiorQueRec([2, 5, 1, 6], 3, L).
L = [5, 6].
*/

maiorQueRec([], _, []).
maiorQueRec([H | T], N, [H | L]) :-
	H > N, !,
	maiorQueRec(T, N, L).

/* 
% Se ajudar, tambem pode ser:
maiorQueRec([H | T], N, L1) :-
	H > N, !,
	maiorQueRec(T, N, L), 
	L1 = [H|L].
*/

maiorQueRec([H | T], N, L) :-
	H =< N, !,
	maiorQueRec(T, N, L).

/* 
maiorQueRIt(L1, N, L2) e verdade se L2 for a lista com os 
elementos de L1 maiores que N (versao iterativa).

?- maiorQueIt([2, 5, 1, 6], 3, L).
L = [5, 6].
*/

maiorQueIt(L1, N, L2) :- 
    maiorQueIt(L1, N, L2, []). % engorda o predicado

maiorQueIt([], _, Acc, Acc).

maiorQueIt([H | T], N, L, Ac) :-
	H > N, !,
	append(Ac, [H], Ac1), 
	% Nota: se fosse Ac1 = [H | Ac], a lista ficava invertida
	maiorQueIt(T, N, L, Ac1).

maiorQueIt([H | T], N, L, Ac) :-
	H =< N, !,
	maiorQueIt(T, N, L, Ac).
