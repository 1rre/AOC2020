defmodule Day7 do
  def contains(bag, map) do
    case Map.get(map, bag) do
      nil -> 0
      bags -> (Enum.map(bags, fn {num, bag} ->
        num + num * contains(bag, map)
      end) |> Enum.sum)
    end
  end
end

map = File.read!("day_7")
|> String.trim
|> String.split("\n")
|> Enum.map(&String.split(&1, " bags contain "))
|> Enum.reduce(%{}, fn [bag, contain], acc ->
  Regex.scan(~r/(?<count>\d+) (?<type>[^,]+) bag(s?)/, contain, capture: :all_names)
  |> Enum.reduce(acc, fn [num, contain], acc ->
    if Map.has_key?(acc, bag) do
      update_in(acc, [bag], &[{String.to_integer(num), contain} | &1])
    else
      Map.put(acc, bag, [{String.to_integer(num), contain}])
    end
  end)
end)

Day7.contains("shiny gold", map)
|> IO.puts()
