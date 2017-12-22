defmodule Helpers.Find do
  @moduledoc """
  Implements methods to find elements in given collections by pattern matching.
  """

  @doc """
  Finds the first element in a list to match a given pattern.
  """
  def first_match(collection, key) do
    Enum.find(collection, &match(&1, key))
  end

  @doc """
  Finds all the elements in a list that match a given pattern.
  """
  def all_matches(collection, key) do
    Enum.filter(collection, &match(&1, key))
  end

  # private
  def match(element, key) do
    element |> elem(0) |> String.downcase === key |> String.downcase
  end
end