defmodule Day9 do
@target 41682220

  def find_weakness(input) do
    Enum.reduce_while(input, input, fn _, acc ->
      Enum.reduce_while(acc, [], fn i, acc ->
        case Enum.sum(acc) do
          @target -> {:halt, acc}
          x when x > @target -> {:halt, nil}
          _ -> {:cont, [i | acc]}
        end
      end)
      |> case do
        nil -> {:cont, tl(acc)}
        x -> {:halt, Enum.min(x) + Enum.max(x)}
      end
    end)
  end
end

File.read!("day_9")
|> String.trim
|> String.split("\n")
|> Enum.map(&String.to_integer/1)
|> Day9.find_weakness
|> IO.puts()
