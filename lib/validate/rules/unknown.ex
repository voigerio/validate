defmodule Validate.Rules.Unknown do
  @moduledoc false

  import Validate.Validator

  def validate(%{value: value, arg: :allow, input: input, rules: rules}) do
    atomize = Keyword.get(rules, :atomize)

    exclude_keys = if atomize do
      Map.keys(value) ++ rules |> Keyword.get(:map, %{}) |> Map.keys() |> Enum.map(&Atom.to_string/1)
    else
      Map.keys(value)
    end

    success(Map.merge(value, Map.drop(input, exclude_keys)))
  end

  def validate(%{value: value, arg: :remove, rules: rules}) do
    expected = Map.keys(Keyword.get(rules, :map, %{}))
    actual = Map.keys(value)
    unknowns = actual -- expected
    success(Map.drop(value, unknowns))
  end

  def validate(%{value: value, arg: :reject, rules: rules}) do
    expected = Map.keys(Keyword.get(rules, :map, %{}))
    actual = Map.keys(value)
    unknown = actual -- expected

    if (unknown) == [] do
      success(value)
    else
      error("unknown keys: #{Enum.join(unknown, ", ")}")
    end
  end
end
