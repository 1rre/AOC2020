-module(day_13_help).
-export([find_r/3]).

find_r(List, N, X) when N rem 1000000 == 0 ->
  io:fwrite("~B~n", [N]),
  case lists:all(fun({A,B}) -> A - (N rem A) == B end, List) of
    true -> 
      io:fwrite("~B~n", [N]),
      halt(0);
    _ -> find_r(List, N + X, X)
  end;

find_r(List, N, X) ->
  case lists:all(fun({A,B}) -> A - (N rem A) == B end, List) of
    true -> 
      io:fwrite("~B~n", [N]),
      halt(0);
    _ -> find_r(List, N + X, X)
 end.
