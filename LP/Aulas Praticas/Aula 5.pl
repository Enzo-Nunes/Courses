insere_ordenado(El, [], [El]).
insere_ordenado(El, [H|T], [El,H|T]) :- El =< H.
insere_ordenado(El, [H|T1], [H|T2])  :- El > H, insere_ordenado(El, T1, T2).