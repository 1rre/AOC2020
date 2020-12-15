defmodule Day9 do
@preamble 25
@previous 25

def extract_preamble(input) do
  Enum.split(input, @preamble)
end

def find_weakness({preamble, list}) do
  Enum.reduce_while(list, preamble, fn v, acc ->
    if Enum.any?(acc, &Enum.any?(acc, fn x -> x != &1 && x + &1 == v end)) do
      {:cont, tl(acc) ++ [v]}
    else
      {:halt, v}
    end
  end)
end
end

File.read!("day_9")
|> String.trim
|> String.split("\n")
|> Enum.map(&String.to_integer/1)
|> Day9.extract_preamble
|> Day9.find_weakness
|> IO.puts()
