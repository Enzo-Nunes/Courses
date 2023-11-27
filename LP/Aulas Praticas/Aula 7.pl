insere_ordenado(E, L1, L2) :-
    findall(M, (member(M, L1), M < E), Menores),
    append(Menores, Maiores, L1),
    append(Menores, [E, Temp]),
    append(Temp, Maiores, L2).

junta_novo_aleatorio(L1, Lim_Inf, Lim_Sup, L2) :-
    findall(M, between(Lim_Inf, Lim_Sup, M), Todos),
    subtract(Todos, L1, Res),
    length(Res, Length),
    random_between(1, Length, Index),
    nth1(Index, Res, N),
    insere_ordenado(N, L1, L2).
    

repete_el(E, N, L) :-
    length(L1, N),
    findall(E, member(N, L1), L).