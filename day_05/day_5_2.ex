defmodule Day5 do
  def find_row(str, row\\Enum.to_list(0..127))
  def find_row(str, row) when length(row) == 1, do: hd(row) * 8 + find_aisle(str)
  def find_row(<<?F, rest::bits>>, row), do: find_row(rest, Enum.take(row, length(row) |> div(2)))
  def find_row(<<?B, rest::bits>>, row), do: find_row(rest, Enum.drop(row, length(row) |> div(2)))

  def find_aisle(str, pos\\Enum.to_list(0..7))
  def find_aisle(_, pos) when length(pos) == 1, do: hd(pos)
  def find_aisle(<<?L, rest::bits>>, pos), do: find_aisle(rest, Enum.take(pos, length(pos) |> div(2)))
  def find_aisle(<<?R, rest::bits>>, pos), do: find_aisle(rest, Enum.drop(pos, length(pos) |> div(2)))
end


seats = File.read!("day_5")
|> String.trim
|> String.split("\n")
|> Enum.map(&Day5.find_row/1)
|> Enum.sort

row = (seats
|> Enum.map(&div(&1, 8))
|> Enum.frequencies
|> Enum.to_list
|> Enum.find(&elem(&1, 1) == 7)
|> elem(0)) * 8

filled = seats
|> Enum.filter(& &1 in row..row+8)

Enum.filter(row..row+8, & &1 not in filled)
|> hd
|> IO.puts
