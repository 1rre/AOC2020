defmodule Day6 do
  def get_count(lines) do
    g_size = length(lines)
    Enum.map(lines, &to_charlist/1)
    |> List.flatten
    |> Enum.frequencies
    |> Map.values
    |> Enum.count(&g_size == &1)
  end
end

File.read!("day_6")
|> String.trim
|> String.split("\n\n")
|> Enum.map(&String.split(&1, "\n") |>  Day6.get_count)
|> Enum.sum
|> IO.puts
