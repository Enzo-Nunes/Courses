substitui_arg(T_c, Arg, Novo_Arg, Novo_T_c) :-
    T_c =.. [F|Args],
    substitui_arg_lista(Args, Arg, Novo_Arg, Novo_Args), !,
    Novo_T_c =.. [F|Novo_Args].

substitui_arg_lista([], _, _, []) :- !.
substitui_arg_lista([Arg|Args], Arg, Novo_Arg, [Novo_Arg|Novo_Args]) :-
    substitui_arg_lista(Args, Arg, Novo_Arg, Novo_Args).
substitui_arg_lista([ArgDif|Args], Arg, Novo_Arg, [ArgDif|Novo_Args]) :-
    ArgDif \= Arg,
    substitui_arg_lista(Args, Arg, Novo_Arg, Novo_Args).

quantos(Pred, Lst, N) :-
    findall(El, (member(El, Lst), T_c =.. [Pred, El], call(T_c)), Lst_Pred),
    length(Lst_Pred, N).

soma_1(X, Y) :- Y is X + 1.
transforma(_, [], []) :- !.
transforma(Pred, [H1|T1], [H2|T2]) :-
    T_c =.. [Pred, H1, H2],
    call(T_c),
    transforma(Pred, T1, T2).