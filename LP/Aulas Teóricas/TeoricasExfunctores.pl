%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Exemplos Teorica %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* 

Exercício (1)

Considere-se o exercicio da Prof Ana Cardoso:

separa(Numeros, Positivos, Negativos) e verdade se Positivos contem os numeros
positivos da lista Numeros e Negativos contem os numeros negativos da lista Numeros.

Exemplo:  
?- separa([1, -2, 5, -1, 0, 1, -4], ListPos, ListNeg).
ListPos = [1, 5, 0, 1],
ListNeg = [-2, -1, -4].

Imaginemos que nao gosto do nome separa e quero poder invocar o predicado fazendo
pos_para_um_lado_neg_para_outro, sem ter de redefinir o predicado.

?- pos_para_um_lado_neg_para_outro([1, -2, 5, -1, 0, 1, -4], ListPos, ListNeg).
ListPos = [1, 5, 0, 1],
ListNeg = [-2, -1, -4].

*/

/* Codigo da Prof. Ana */
separa([], [], []) :- !.

separa([N | Resto], [N | Positivos], Negativos) :-
       N >= 0, !, separa(Resto, Positivos, Negativos).

separa([N | Resto], Positivos, [N | Negativos]) :-
       N < 0, !, separa(Resto, Positivos, Negativos).

/* Nova invocacao */
pos_para_um_lado_neg_para_outro(L, Pos, Neg) :-
    T =.. [separa, L, Pos, Neg], call(T).


/*
Exercício (2) 

A Maria, o Francisco e o Manuel implementaram um predicado que soma dois numeros e 
devolve a sua soma. Dao-me exemplos de resultados obtidos e eu quero ver se bate certo 
com as minhas implementacoes de soma (mysoma1 e mysoma2).

Exemplo:
?- testes([somaMaria(1, 1, 2), somaFrancisco(2, 1, 3), somaManuel(2,4, 6)], mysoma1).
true % ou seja, quero ver se se verifica mysoma(1, 1, 2), mysoma(2, 1, 3), etc.

?- testes([somaMaria(1, 1, 2), somaFrancisco(2, 1, 3), somaManuel(2,4, 6)], mysoma2).
false
*/

/* Auxiliares */

% Z e a soma de X e Y
mysoma1(X, Y, Z) :- Z is X + Y.

% O seguinte Vai dar asneira. Z vais ser +(X, Y)
mysoma2(X, Y, Z) :- Z = X + Y. % lembrar que o = unifica, sem avaliar X + Y.

/* Codigo testes */
testes([], _).
testes([H | T], Pred) :- H =.. [ _ | Args], % permite-me ir buscar os argumentos dos somas
              L =.. [Pred | Args], % Para aplicar Pred a todos os argumentos dos somas
              write(L), % so para ver como fica lindinho
              call(L), % Executa
              testes(T, Pred). % Ataca o resto da lista

/*
Exercício (3) 

Para predicado unarios: definir verificaLista(Prop, Lista, Lista1, Lista2) que e verdade 
se todos os elementos de Lista que verificam Prop vao para Lista1; os restantes para 
Lista2.

?- verificaLista(number, [0, -3, 4], L1, L2).
L1 = [0, -3, 4],
L2 = [].
?- verificaLista(number, [0, -3, 4, a], L1, L2).
L1 = [0, -3, 4],
L2 = [a].
?- verificaLista(par, [0, -3, 4], L1, L2).
L1 = [0, 4],
L2 = [-3].
?- verificaLista(number, [0, -3, [1, 2], 4, a], L1, L2).
L1 = [0, -3, 4],
L2 = [[1, 2], a].
*/

/* Auxiliares */

par(X) :- number(X), X mod 2 =:= 0. % Verifica se um elemento e par

/* Codigo que coloca os elementos da lista que verificam a propriedade Prop na lista do
terceiro argumento e os que nao verificam na lista do quarto argumento */
verificaLista(_, [], [], []) :- !.
verificaLista(Pred, [Head | Tail], [Head | L1], L2) :- 
    T =.. [Pred, Head],
    call(T), !, 
    verificaLista(Pred, Tail, L1, L2).

verificaLista(Pred, [Head | Tail], L1, [Head | L2]) :- 
    verificaLista(Pred, Tail, L1, L2).

/* Sem usar functores */
verificaListaAlternativo(Pred, L, L1, L2) :- include(Pred, L, L1), exclude(Pred, L, L2).
