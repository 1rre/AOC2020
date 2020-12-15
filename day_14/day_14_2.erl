-module(day_14).
-export([main/1]).

main([File]) ->
  {ok, Input} = file:read_file(File),
  Lines = [binary_to_list(X) || X <- string:split(string:trim(Input), "\n", all)],
  Map = result(Lines, nil),
  Result = [X || {_,X} <- maps:to_list(Map)],
  io:fwrite("~B~n", [lists:sum(Result)]).

result([[$m,$a,$s,$k,$ ,$=,$ | Mask] | Rest], _) -> result(Rest, Mask);
result([[$m,$e,$m,$[ | MemLoc] | Rest], Mask) ->
  Map = result(Rest, Mask),
  [AddressStr, DataStr] = string:split(MemLoc, "] = "),
  AddressBin = integer_to_list(list_to_integer(AddressStr), 2),
  replace_data(pad(AddressBin), Mask, list_to_integer(DataStr), Map);
result([], _) -> #{}.

pad(X) when length(X) >= 36 -> X;
pad(X) -> pad([$0 | X]).

replace_data(Addr, Mask, Data, Map) ->
  Locs = [list_to_integer(X) || X <- get_address(Addr, Mask)],
  lists:foldl(fun
                (I, Map) -> case maps:is_key(I,Map) of 
                              false -> maps:put(I, Data, Map);
                              true -> Map
                            end
              end, Map, Locs).

get_address([X | Addr], [$0 | Mask]) ->
  [[X |  L] || L <- get_address(Addr, Mask)];
get_address([_ | Addr], [$1 | Mask]) ->
  [[$1 | L] || L <- get_address(Addr, Mask)];
get_address([_ | Addr], [$X | Mask]) -> 
  [[$0 | L] || L <- get_address(Addr, Mask)] ++ [[$1 | L] || L <- get_address(Addr, Mask)];
get_address([], []) -> [""].

