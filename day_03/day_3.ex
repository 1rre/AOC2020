defmodule Day3 do
  def get_input do
    File.read!("input")
    |> String.split("\n")
    |> Enum.map(&to_charlist/1)
  end

  def run(list, _, y, _, _) when y >= length(list), do: 0
  def run(list, x, y, a, b) do
    Enum.at(list, y)
    |> Enum.at(x)
    |> case do
      ?# -> run(list, rem(x + a, length(hd(list))), y + b, a, b) + 1
      _  -> run(list, rem(x + a, length(hd(list))), y + b, a, b)
    end
  end

  def part(1) do
    input = get_input()
    run(input, 0, 0, 3, 1)
  end

  def part(2) do
    input = get_input()

    run(input, 0, 0, 1, 1) *
    run(input, 0, 0, 3, 1) *
    run(input, 0, 0, 5, 1) *
    run(input, 0, 0, 7, 1) *
    run(input, 0, 0, 1, 2)
  end

end


case Enum.at(System.argv, 0) do
  "1" -> Day3.part(1)
  "2" -> Day3.part(2)
  _   -> raise "No args given"
end
|> IO.puts
