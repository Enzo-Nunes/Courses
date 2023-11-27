nao_membro(_, []).
nao_membro(X, [H|T]) :- X \= H, nao_membro(X, T).

insere_ordenado(El, [], [El]).
insere_ordenado(El, [H | T], [El, H | T]) :- El < H.
insere_ordenado(El, [H|T], [H|Res]) :- El >= H, insere_ordenado(El, T, Res).