defmodule Day8 do
  def run(list, bk\\false, n\\0, acc\\0, history\\MapSet.new)
  def run(list, bk, n, acc, history) do
    if MapSet.member?(history, n) do
      false
    else
      case Enum.at(list, n) do
        nil -> acc
        {"nop", x} ->
          case run(list, bk, n + 1, acc, MapSet.put(history, n)) do
            false when bk -> false
            false -> run(list, true, n + x, acc, MapSet.put(history, n))
            a -> a
          end
        {"jmp", x} -> 
          case run(list, bk, n + x, acc, MapSet.put(history, n)) do
            false when bk -> false
            false -> run(list, true, n + 1, acc, MapSet.put(history, n))
            a -> a
          end
        {"acc", x} -> run(list, bk, n + 1, acc + x, MapSet.put(history, n))
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
