defmodule Helpers.Find do
  @moduledoc false

  @doc """
  Finds the first element in a list to match a given pattern.

  Returns `tuple`.
  """
  def first_match(collection, key) do
    Enum.find(collection, &match(&1, key))
  end

  @doc """
  Finds all the elements in a list that match a given pattern.

  Returns `List`.
  """
  def all_matches(collection, key) do
    Enum.filter(collection, &match(&1, key))
  end

  @doc false
  def match(element, key) do
    element |> elem(0) |> String.downcase() === key |> String.downcase()
  end
end
