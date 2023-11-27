somaRec([], 0).
somaRec([H | T], X) :- somaRec(T, Rest), X is H + Rest.