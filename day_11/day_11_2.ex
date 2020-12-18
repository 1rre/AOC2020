defmodule Day11 do
  def find_seat({x,y}, {a,b}, list) do
    if x<0 or y<0 do
      false
    else
      case Enum.at(list, x, []) |> Enum.at(y) do
        nil -> false
        ?. -> find_seat({x+a,y+b}, {a,b}, list)
        ?# -> true
        ?L -> false
      end
    end
  end 
  def count_adjacent({x,y}, list) do
    [
      find_seat({x+1,y+1}, {1,1}, list),
      find_seat({x+1,y}, {1,0}, list),
      find_seat({x+1,y-1}, {1,-1}, list),
      find_seat({x,y+1}, {0,1}, list),
      find_seat({x,y-1}, {0,-1}, list),
      find_seat({x-1,y+1}, {-1,1}, list),
      find_seat({x-1,y}, {-1,0}, list),
      find_seat({x-1,y-1}, {-1,-1}, list),
    ]
    |> Enum.count(&true == &1)
  end

  def seats(list) do
    Enum.map(0..length(list) - 1, fn i ->
      Enum.map(0..length(hd(list)) - 1, fn j ->
        case Enum.at(list, i) |> Enum.at(j) do
          ?. -> ?.
          ?# -> if Day11.count_adjacent({i,j},list) >= 5, do: ?L, else: ?#
          _ -> if Day11.count_adjacent({i,j}, list) == 0, do: ?#, else: ?L
        end
      end)
    end)
  end

  def run(list, last\\nil)
  def run(list, list) do
    List.flatten(list)
    |> Enum.count(&?#==&1)
  end
  def run(list, last) do
    run(seats(list), list)
  end
end

File.read!("day_11")
|> String.trim
|> String.split("\n")
|> Enum.map(&to_charlist/1)
|> Day11.run
|> IO.puts
