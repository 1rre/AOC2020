-module(day_15).
-export([main/1]).

main(_) -> 
  Result = result(#{9 => 1, 19 => 2, 1 => 3, 6 => 4, 0 => 5, 5 => 6}, 4, 7),
  io:fwrite("~B~n", [Result]).

result(_, Last, 30000000) -> Last;
result(Map, Last, I) when I rem 100000 == 0 ->
  io:fwrite("~B~n", [I]),
  case maps:is_key(Last, Map) of
    true -> result(maps:put(Last, I, Map), I - maps:get(Last, Map), I + 1);
    _ -> result(maps:put(Last, I, Map), 0, I + 1)
  end;
result(Map, Last, I) ->
%  io:fwrite("~B~n", [I]),
  case maps:is_key(Last, Map) of
    true -> result(maps:put(Last, I, Map), I - maps:get(Last, Map), I + 1);
    _ -> result(maps:put(Last, I, Map), 0, I + 1)
  end.
