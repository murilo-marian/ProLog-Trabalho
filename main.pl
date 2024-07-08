maior_menor(X, Y, Z,Maior,Menor):- 
  (X >= Y, X >= Z -> Maior is X; Y >= X, Y >= Z -> Maior is Y; Maior is Z),
  (X =< Y, X =< Z -> Menor is X; Y =< X, Y =< Z -> Menor is Y; Menor is Z).
numero50_100(N) :- between(50, 100, N).
idade(I, FaixaEtaria):- 
  (I =< 12 -> FaixaEtaria = crianca; 
  I =< 18 -> FaixaEtaria = adolescente; 
  I =< 65 -> FaixaEtaria = adulto; 
  FaixaEtaria = idoso).
cubo(X):-
  between(1, X, R), 
  Cubo is R * R * R, 
  writeln(Cubo).
entre(N1, N2):-
  between(N1, N2, Entre), write(Entre).

fatorial(N, Retorno):- 
  N == 1 -> Retorno = 1; N1 is N - 1, 
  fatorial(N1, R2), 
  Retorno is R2 * N.
potencia(_, 0, 1).
potencia(N1, Exp, P):-
  Exp > 0,
  Exp1 is Exp - 1,
  potencia(N1, Exp1, P2),
  P is N1 * P2.
distancia((X, Y), (A, B), Retorno):-
  Dx is X - A,
  Dy is Y - B,
  Retorno is sqrt(Dx * Dx + Dy * Dy).
estrelas(0):- !.
estrelas(X):-
  X > 0,
  write('*'),
  X2 is X - 1,
  estrelas(X2).
quadrado(0, _):- !.
quadrado(N, Char):-
  N > 0,
  quadrado2(N, N, Char).
quadrado2(_, 0, _):- !.
quadrado2(Num, Recur, Char):-
  Recur > 0,
  linha(Num, Char), nl,
  Recur2 is Recur - 1,
  quadrado2(Num, Recur2, Char).
linha(0, _):- !.
linha(N, Char) :-
  N > 0,
  write(Char),
  N1 is N - 1,
  linha(N1, Char).
  