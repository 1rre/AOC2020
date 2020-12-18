defmodule Day3 do
  def read do
    File.read!("day_3")
    |> String.trim
    |> String.split("\n")
  end
  def go(l, a, b, i, j) do
    IO.puts("a: #{a}, b: #{b}")
    IO.puts(Enum.at(l, a))
    case Enum.at(l, a) do
      nil -> 0
      x -> case String.at(x, b) do
        "#" -> 1 + go(l, a + i, rem(b + j, String.length(x)), i, j)
        nil -> 0
        _ -> 0 + go(l, a + i, rem(b + j, String.length(x)), i, j)
      end
    end
  end
end

r = Day3.read

Day3.go(r,1,1,1,1) *
Day3.go(r,1,3,1,3) *
Day3.go(r,1,5,1,5) *
Day3.go(r,1,7,1,7) *
Day3.go(r,2,1,2,1)
|> IO.puts
