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
  Address = list_to_integer(AddressStr),
  case maps:is_key(Address, Map) of
    true -> Map;
    _ -> Data = list_to_integer(DataStr),
         DataBin = integer_to_list(Data, 2),
         MaskBin = [if Y == $0 -> $0; Y == $1 -> $1; true -> X end || {X,Y} <- lists:zip(pad(DataBin), Mask)],
         maps:put(Address, list_to_integer(MaskBin, 2), Map)
  end;
result([], _) -> #{}.


pad(X) when length(X) >= 36 -> X;
pad(X) -> pad([$0 | X]).
