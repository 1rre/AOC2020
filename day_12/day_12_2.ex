defmodule Day12 do
  def parse(cmds, wp\\{10,1}, ship\\{0,0})
  def parse([], _, {a,b}), do: abs(a) + abs(b)
  def parse([<<command::8, arg::bits>> | rest], {a,b}, {x,y}) do
    case command do
      ?E -> parse(rest, {a + String.to_integer(arg), b}, {x,y})
      ?S -> parse(rest, {a, b - String.to_integer(arg)}, {x,y})
      ?W -> parse(rest, {a - String.to_integer(arg), b}, {x,y})
      ?N -> parse(rest, {a, b + String.to_integer(arg)}, {x,y})
      ?R -> parse(rest, rotate({a,b}, String.to_integer(arg) |> div(90)), {x,y})
      ?L -> parse(rest, rotate({a,b}, 4 + (String.to_integer(arg) |> div(-90))), {x,y})
      ?F -> parse(rest, {a,b}, {x + String.to_integer(arg) * a, y + String.to_integer(arg) * b}) 
    end
  end
  
  defp rotate({x,y}, by) do
    case by do
      1 -> {y,-x}
      2 -> {-x,-y}
      3 -> {-y,x}
    end
  end

end

File.read!("input/day_12")
|> String.trim
|> String.split("\n")
|> Day12.parse
|> IO.puts

