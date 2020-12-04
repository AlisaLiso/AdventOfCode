string = String.trim_trailing(File.read!("2020-elixir/inputDay4.txt"))
defmodule Day4 do
  def countValidation(passport) do
    if String.contains?(passport, "byr")
      && String.contains?(passport, "iyr")
      && String.contains?(passport, "eyr") && String.contains?(passport, "hgt") && String.contains?(passport, "hcl") && String.contains?(passport, "ecl") && String.contains?(passport, "ecl") && String.contains?(passport, "pid") && part2(passport) do
      1
    else
      0
    end
  end

  def part2(passport) do
    passport
      |> String.split(["\n", " "])
      |> Enum.map(fn x -> String.split(x, ":") end)
      |> Enum.reduce([], fn x, acc ->
        [att, value] = x

        case att do
          "byr" ->
            integer = String.to_integer(value)
            if integer >= 1920 && integer <= 2002 do
              [true | acc]
            else
              [false | acc]
            end

          "iyr" ->
            integer = String.to_integer(value)
            if integer >= 2010 && integer <= 2020 do
              [true | acc]
            else
              [false | acc]
            end

          "eyr" ->
            integer = String.to_integer(value)
            if integer >= 2020 && integer <= 2030 do
              [true | acc]
            else
              [false | acc]
            end

          "hgt" ->
            letters = String.split(value, ~r/^[[:digit:]]+/) |> List.last
            numbers = String.split(value, ~r/[[:alpha:]]+/) |> List.first |> String.to_integer

            case letters do
              "cm"
                -> if numbers >= 150 && numbers <= 193, do: [true | acc], else: [false | acc]

              "in"
                -> if numbers >= 59 && numbers <= 76, do: [true | acc], else: [false | acc]

              ""
                -> [false | acc]
            end

          "hcl" ->
            if String.length(value) === 7 && String.match?(value, ~r/^#[0-9a-f]+$/) do
              [true | acc]
            else
              [false | acc]
            end

          "ecl" ->
            colors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

            if Enum.member?(colors, value) do
              [true | acc]
            else
              [false | acc]
            end

          "pid" ->
            if String.length(value) === 9 && String.match?(value, ~r/^[[:digit:]]+$/) do
              [true | acc]
            else
              [false | acc]
            end

          "cid" ->
            [true | acc]
        end
      end)
      |> Enum.all?(fn(s) -> s === true end)
  end

  def passwords(string) do
    splited = String.split(string, ["\n\n"])
    splited
      |> Enum.reduce(0, fn x, acc ->
        acc + countValidation(x)
      end)
      |> IO.inspect(charlists: :as_lists);
  end
end

Day4.passwords(string)
