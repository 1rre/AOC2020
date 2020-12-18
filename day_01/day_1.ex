defmodule Day1 do

  def get_input do
    File.read!("input")
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  def part(1) do

    input = get_input()

    Enum.reduce_while(input, input, fn x, acc ->
      case Enum.find(acc, & x + &1 == 2020) do
        nil -> {:cont, tl(acc)}
        y   -> {:halt, x * y}
      end
    end)

  end

  def part(2) do

    input = get_input()

    Enum.reduce_while(input, tl(input), fn x, acc ->
      Enum.reduce_while(acc, tl(acc), fn y, acc ->
        case Enum.find(acc, & x + y + &1 == 2020) do
          nil when acc == [] -> {:halt, nil}
          nil                -> {:cont, tl(acc)}
          z                  -> {:halt, x * y * z}
        end
      end)
      |> case do
        nil -> {:cont, tl(acc)}
        n   -> {:halt, n}
      end
    end)

  end

end


case Enum.at(System.argv, 0) do
  "1" -> Day1.part(1)
  "2" -> Day1.part(2)
  _   -> raise "No args given"
end
|> IO.puts
