-module(day_13).
-export([main/1]).

main([File]) ->
  {ok, Input} = file:read_file(File),
  [_, Buses] = string:split(Input, "\n"),
  BusList = string:split(string:trim(Buses), ",", all),
  [{A0,A1} | [B | BWI]] = [{binary_to_integer(X),Y} || {X,Y} <- lists:zip(BusList, lists:seq(0, length(BusList) - 1)), not (X == <<"x">>)],
  io:fwrite("~B~n", [A1 + search(A0, A0, B, BWI, false)]).

search(N, _, {B, T}, [], _) when (N+T) rem B == 0 -> N;
search(N, A, {B, T}, BWI, false) when (N+T) rem B == 0 -> search(N + A, A, {B, T}, BWI, N);
search(N, _, {B, T}, [Hd | BWI], X) when (N+T) rem B == 0 -> search(X, N - X, Hd, BWI, false);
search(N, A, {B, T}, BWI, X) -> search(N + A, A, {B, T}, BWI, X).

