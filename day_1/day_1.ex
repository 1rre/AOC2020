x = File.read!("day_1")
|> String.trim
|> String.split("\n")
|> Enum.map(&String.to_integer/1)

Enum.reduce_while(x, tl(x), fn a, acc ->
  Enum.reduce_while(acc, tl(acc), fn b, acc ->
    Enum.find(acc, fn c -> a + b + c == 2020 end)
    |> case do
      nil when length(acc) > 0 -> {:cont, tl(acc)}
      nil -> {:halt, nil}
      c ->
        IO.puts("b: #{b}, c: #{c}")
        {:halt, b * c}
    end
  end)
  |> case do
    b when is_integer(b) ->
      IO.puts("a: #{a}")
      {:halt, a * b}
    _ -> {:cont, tl(acc)}
  end
end)
|> IO.puts()
