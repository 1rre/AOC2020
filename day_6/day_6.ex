File.read!("day_6")
|> String.trim
|> String.split("\n\n")
|> Enum.map(&String.replace(&1, ~r/[[:space:]]/, "") |> to_charlist |> Enum.uniq |> length)
|> Enum.sum
|> IO.puts
