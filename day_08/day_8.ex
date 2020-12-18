defmodule Day8 do
  def run(list, n\\0, acc\\0, history\\MapSet.new)
  def run(list, n, acc, history) do
    if MapSet.member?(history, n) do
      acc
    else
      case Enum.at(list, n) do
        {"nop", _} -> run(list, n + 1, acc, MapSet.put(history, n))
        {"jmp", x} -> run(list, n + x, acc, MapSet.put(history, n))
        {"acc", x} -> run(list, n + 1, acc + x, MapSet.put(history, n))
      end
    end
  end
end

File.read!("day_8")
|> String.trim
|> String.split("\n")
|> Enum.map(fn x ->
  [a, b] = String.split(x, " ")
  {a, String.to_integer(b)}
end)
|> Day8.run
|> IO.puts
