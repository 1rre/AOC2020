defmodule Day11 do
  def count_adjacent({x,y}, list) when x > 0 and y > 0 do
    [
      {x + 1, y + 1},
      {x + 1, y},
      {x + 1, y - 1},
      {x, y + 1},
      {x, y - 1},
      {x - 1, y + 1},
      {x - 1, y},
      {x - 1, y - 1}
    ]
    |> Enum.count(fn {a, b} -> Enum.at(list, a, []) |> Enum.at(b) == ?# end)
  end
  def count_adjacent({x,y}, list) when x > 0 do
    [
      {x + 1, y},
      {x + 1, y + 1},
      {x, y + 1},
      {x - 1, y},
      {x - 1, y + 1}
    ]
    |> Enum.count(fn {a, b} -> Enum.at(list, a, []) |> Enum.at(b) == ?# end)
  end
  def count_adjacent({x,y}, list) when y > 0 do
    [
      {x + 1, y},
      {x + 1, y + 1},
      {x + 1, y - 1},
      {x, y + 1},
      {x, y - 1}
    ]
    |> Enum.count(fn {a, b} -> Enum.at(list, a, []) |> Enum.at(b) == ?# end)
  end
  def count_adjacent({x,y},  list) do
    [
      {x + 1, y},
      {x + 1, y + 1},
      {x, y + 1}
    ]
    |> Enum.count(fn {a, b} -> Enum.at(list, a, []) |> Enum.at(b) == ?# end)
  end

  def seats(list) do
    Enum.map(0..length(list) - 1, fn i ->
      Enum.map(0..length(hd(list)) - 1, fn j ->
        case Enum.at(list, i) |> Enum.at(j) do
          ?. -> ?.
          ?# -> if Day11.count_adjacent({i,j},list) >= 4, do: ?L, else: ?#
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
