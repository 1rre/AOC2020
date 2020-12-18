defmodule Day5 do
  def get_input() do
    File.read!("input")
    |> String.split("\n")
  end

  def find([x, y | rest]) when x + 1 == y, do: find([y | rest])
  def find([x | _]), do: x + 1
  
  def get_ids(line) do

    row = Enum.reduce_while(to_charlist(line), {0, 127}, fn
      ?F, {a, b} -> {:cont, {a, b - div(b - a + 1, 2)}}
      ?B, {a, b} -> {:cont, {a + div(b - a + 1, 2), b}}
      _ , {a, a} -> {:halt, a}
      _ , {a, b} -> raise "#{a} =/= #{b}"
    end)

    {col, col} = Enum.reduce(to_charlist(line), {0,7}, fn
      ?L, {a, b} -> {a, b - div(b - a + 1, 2)}
      ?R, {a, b} -> {a + div(b - a + 1, 2), b}
      _ , acc    -> acc
    end)

    row * 8 + col
  end

  def part(1) do
    input = get_input()

    Enum.map(input, &get_ids/1)
    |> Enum.max
  end

  def part(2) do
    input = get_input()
    Enum.map(input, &get_ids/1)
    |> Enum.sort
    |> find
  end

end

case Enum.at(System.argv, 0) do
  "1" -> Day5.part(1)
  "2" -> Day5.part(2)
  _   -> raise "No args given"
end
|> IO.puts
