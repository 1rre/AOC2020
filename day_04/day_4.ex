File.read!("day_4")
|> String.trim
|> String.split("\n\n")
|> Enum.map(&String.split(&1, ~r/[[:space:]]+/) |> Enum.sort |> Enum.join(" "))
|> Enum.map(&Regex.run(~r/^byr:(?<byr>\d{4})(\scid:\d+)?\secl:(amb|blu|brn|gry|grn|hzl|oth)\seyr:(?<eyr>\d{4})\shcl:\#[[:xdigit:]]{6}\shgt:(?<hgt>(\d{2}in|\d{3}cm))\siyr:(?<iyr>\d{4})\spid:\d{9}$/, &1, capture: :all_names))
|> Enum.reject(&nil==&1)
|> Enum.map(fn x -> Enum.map(x, &Integer.parse(&1)) end)
|> Enum.count(fn
  [{a,_}, {b,_}, {c,"in"}, {d,_}] -> a in 1920..2002 && b in 2020..2030 && c in 56..76 && d in 2010..2020
  [{a,_}, {b,_}, {c,"cm"}, {d,_}] -> a in 1920..2002 && b in 2020..2030 && c in 150..193 && d in 2010..2020
end)
|> IO.puts
