# Day 2: Password Philosophy
string = String.trim_trailing(File.read!("2020-elixir/inputDay2.txt"))

defmodule Day2 do
  def parsedString(string) do
    splited_by_space = String.split(string, "\n")

    Enum.map(splited_by_space, fn x ->
      String.split(x)
    end)
  end

  def validate(array) do
    {num, arr} = List.pop_at(array, 0)
    num_array = String.split(num, "-")
    first = String.to_integer(List.first(num_array))
    last = String.to_integer(List.last(num_array))

    {letterString, arr2} = List.pop_at(arr, 0)
    {string, _none} = List.pop_at(arr2, 0)
    letter = String.first(letterString)

    count_letters = string |> String.graphemes |> Enum.count(& &1 == letter)

    if count_letters >= first && count_letters <= last do
      true
    else
      false
    end
  end

  def findNumberOfValidPasswords(string) do
    parsed = parsedString(string)

    num_of_valid_passwords = Enum.reduce(parsed, 0, fn x, acc ->
      if validate(x) do
        acc + 1
      else
        acc
      end
    end)

    IO.inspect(num_of_valid_passwords, charlists: :as_lists);
  end
end

Day2.findNumberOfValidPasswords(string)
