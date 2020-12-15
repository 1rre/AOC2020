defmodule Day10 do
  def use_adapters(list, i\\0, map\\%{})
  def use_adapters(list, i, map) when map_size(map) == 0 do
    use_adapters(list, i, %{List.last(list) => 1})
  end
  def use_adapters(list, i, map) do
    Map.get(map, Enum.at(list, i))
    |> case do
      nil ->
        {x,y} = (i + 1..length(list) - 1
        |> Enum.reduce_while({map, 0}, fn j, {map, acc} ->
          if Enum.at(list, j) > Enum.at(list, i) + 3 do
            {:halt, {map, acc}}
          else
            {x, y} = use_adapters(list, j, map)
            {:cont, {x, y + acc}}
          end
        end))
       {Map.put(x, Enum.at(list, i), y), y}
      x -> {map, x}
    end
  end
end

[0 | File.read!("input/day_10")
|> String.trim
|> String.split("\n")
|> Enum.map(&String.to_integer/1)
|> Enum.sort]
|> Day10.use_adapters
|> elem(1)
|> IO.puts

