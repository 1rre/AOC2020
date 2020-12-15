defmodule Day10 do
  def use_adapters(list, jolt\\0)
  def use_adapters([], jolt), do: {0, 1}
  def use_adapters(list, jolt) do
    {a, b} = use_adapters(tl(list), hd(list))
    cond do
      hd(list) == jolt + 3 -> {a, b + 1}
      hd(list) == jolt + 1 -> {a + 1, b}
      true -> {a, b}
    end
  end
end

{a, b} = File.read!("day_10")
|> String.trim
|> String.split("\n")
|> Enum.map(&String.to_integer/1)
|> Enum.sort
|> Day10.use_adapters

IO.puts("#{a*b}")

