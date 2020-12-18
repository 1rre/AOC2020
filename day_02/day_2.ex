File.read!("day_2")
|> String.trim
|> String.split("\n")
|> Enum.map(&Regex.run(~r/(?<d0>(\d+))-(?<d1>(\d+))\s(?<nm>(.)):\s(?<ps>(.*))/, &1, capture: :all_names))
|> Enum.count(fn [a,b,c,p] ->
  g = String.graphemes(p)
  l = [Enum.at(g, String.to_integer(a) - 1), Enum.at(g, String.to_integer(b) - 1)]
  Enum.uniq(l) == l && c in l
end)
|> IO.puts()
