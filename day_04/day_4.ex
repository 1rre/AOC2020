defmodule Day4 do
import Bitwise
@byr (((?b<<<8)+?y)<<<8)+?r
@iyr (((?i<<<8)+?y)<<<8)+?r
@eyr (((?e<<<8)+?y)<<<8)+?r
@hgt (((?h<<<8)+?g)<<<8)+?t
@hcl (((?h<<<8)+?c)<<<8)+?l
@ecl (((?e<<<8)+?c)<<<8)+?l
@pid (((?p<<<8)+?i)<<<8)+?d
@cid (((?c<<<8)+?i)<<<8)+?d

  def get_input do
    File.read!("input")
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, ~r/[[:space:]]/))
  end

  def verify_fields([], _), do:
    true

  def verify_fields([<<@byr::24, ?:, v::bits>> | rest], n), do:
    String.to_integer(v) in 1920..2002 and verify_fields(rest, n)

  def verify_fields([<<@iyr::24, ?:, v::bits>> | rest], n), do:
    String.to_integer(v) in 2010..2020 and verify_fields(rest, n)

  def verify_fields([<<@eyr::24, ?:, v::bits>> | rest], n), do:
    String.to_integer(v) in 2020..2030 and verify_fields(rest, n)

  def verify_fields([<<@hgt::24, ?:, v::bits>> | rest], n) do
    {i, units} = Integer.parse(v)
    (units == "in" and i in 59..76 or units == "cm" and i in 150..193) and verify_fields(rest, n)
  end

  def verify_fields([<<@hcl::24, ?:, ?#, v::bits>> | rest], n), do:
    String.length(v) == 6 and Enum.all?(to_charlist(v), & &1 in ?0..?9 or &1 in ?a..?f) and verify_fields(rest, n)

  def verify_fields([<<@ecl::24, ?:, v::bits>> | rest], n), do:
    v in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"] and verify_fields(rest, n)

  def verify_fields([<<@pid::24, ?:, v::bits>> | rest], n), do:
    String.length(v) == 9 and Enum.all?(to_charlist(v), & &1 in ?0..?9) and verify_fields(rest, n)

  def verify_fields([<<@cid::24, ?:, _::bits>> | rest], n), do:
    n == 8 and verify_fields(rest, n)

  def verify_fields(x, _), do:
    false

  def part(1) do
    input = get_input()

    Enum.count(input, fn passport ->
      length(passport) == 8 or
      length(passport) == 7 and Enum.all?(passport, fn
        <<"cid", _::bits>> -> false;
        _                  -> true
      end)
    end)
  end

  def part(2) do
    input = get_input()

    Enum.count(input, fn
      line when length(line) < 7 -> false
      line -> verify_fields(line, length(line))
    end)
  end

end

case Enum.at(System.argv, 0) do
  "1" -> Day4.part(1)
  "2" -> Day4.part(2)
  _   -> raise "No args given"
end
|> IO.puts
