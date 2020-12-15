defmodule Day12 do
  def parse(cmds, direction\\0, position\\{0,0})
  def parse([], _, {x,y}), do: abs(x) + abs(y)
  def parse([<<command::8, arg::bits>> | rest], dir, {x,y}) do
    case command do
      ?E -> parse(rest, dir, {x + String.to_integer(arg), y})
      ?S -> parse(rest, dir, {x, y - String.to_integer(arg)})
      ?W -> parse(rest, dir, {x - String.to_integer(arg), y})
      ?N -> parse(rest, dir, {x, y + String.to_integer(arg)})
      ?R -> parse(rest, rem(dir + div(String.to_integer(arg), 90), 4), {x,y})
      ?L -> parse(rest, rem(dir + 4 - div(String.to_integer(arg), 90), 4), {x,y})
      ?F -> parse(rest, dir, move({x,y}, dir, String.to_integer(arg))) 
    end
  end

  defp move({x,y}, dir, by) do
    case dir do
      0 -> {x + by, y}
      1 -> {x, y - by}
      2 -> {x - by, y}
      3 -> {x, y + by}
    end
  end

end

File.read!("input/day_12")
|> String.trim
|> String.split("\n")
|> Day12.parse
|> IO.puts

