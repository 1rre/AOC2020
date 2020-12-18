-module(day_18).
-export ([main/1]).

main(_Args) ->
  io:fwrite("~B~n", [lists:sum([calc(element(2, parser:parse(element(2, lexer:string(X))))) || X <- string:split(binary_to_list(string:trim(element(2, file:read_file("input")))), "\n", all)])]).


calc({num, _, X}) -> X;
calc({{'*', _}, {A,B}}) -> calc(A) * calc(B);
calc({{'+', _}, {A,B}}) -> calc(A) + calc(B).



