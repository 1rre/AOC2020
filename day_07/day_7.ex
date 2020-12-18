defmodule Day7 do
  def contains(bag, contains, map) do
    IO.puts(bag)
    bag == "shiny gold" || contains != nil && Enum.any?(contains, &contains(&1, Map.get(map, &1), map))
  end
end

map = File.read!("day_7_e")
|> String.trim
|> String.split("\n")
|> Enum.map(&String.split(&1, " bags contain "))
|> Enum.reduce(%{}, fn [bag, contain], acc ->
  Regex.scan(~r/\d (?<type>[^,]+) bag(s?)/, contain, capture: :all_names)
  |> Enum.reduce(acc, fn contain, acc ->
    if Map.has_key?(acc, bag) do
      update_in(acc, [bag], &[hd(contain) | &1])
    else
      Map.put(acc, bag, contain)
    end
  end)
end)
Enum.count(map, fn {bag, contains} ->
  IO.puts("\n\n#{bag}:")
  Day7.contains(bag, contains, map)
end)
|> IO.puts
