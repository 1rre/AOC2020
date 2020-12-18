defmodule Day2 do

  def get_input() do
    File.read!("input")
    |> String.split("\n")
    |> Enum.map(fn line ->
      {x, <<?-, rest::bits>>} = Integer.parse(line)
      {y, <<?\s, c::8, ?:, ?\s, rest::bits>>} = Integer.parse(rest)
      {x, y, c, rest}
    end)
  end

  def count_chars(_, ""), do: 0
  def count_chars(c, <<c::8, rest::bits>>), do: count_chars(c, rest) + 1
  def count_chars(c, <<_::8, rest::bits>>), do: count_chars(c, rest)


  def part(1) do

    input = get_input()

    Enum.count(input, fn {x,y,c,rest} ->
      count = to_charlist(rest)
              |> Enum.count(&c==&1)
      count in x..y
    end)

  end

  def part(2) do

    input = get_input()

    Enum.count(input, fn {x,y,c,rest} ->
      case {String.at(rest, x-1), String.at(rest, y-1)} do
        {<<^c::8>>, <<^c::8>>} -> false
        {<<^c::8>>, _} -> true
        {_, <<^c::8>>} -> true
        _ -> false
      end
    end)

  end

end


case Enum.at(System.argv, 0) do
  "1" -> Day2.part(1)
  "2" -> Day2.part(2)
  _   -> raise "No args given"
end
|> IO.puts
