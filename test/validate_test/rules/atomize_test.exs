defmodule ValidateTest.Rules.AtomizeTest do
  use ExUnit.Case

  import Validate.Validator

  test "it does not convert to atom" do
    rules = [
      type: :map,
      map: %{
        "key" => [type: :string]
      }
    ]

    input = %{"key" => "value"}

    assert Validate.validate(input, rules) == success(%{"key" => "value"})
  end

  test "it convert to atom" do
    rules = [
      type: :map,
      atomize: true,
      map: %{
        :key => [type: :string]
      }
    ]

    input = %{"key" => "value"}

    assert Validate.validate(input, rules) == success(%{:key => "value"})
  end

  test "it converts only atom keys" do
    rules = [
      type: :map,
      atomize: true,
      map: %{
        :key => [type: :string],
        "non_atom" => [type: :string]
      }
    ]

    input = %{"key" => "value", "non_atom" => "value2"}

    assert Validate.validate(input, rules) == success(%{:key => "value", "non_atom" => "value2"})
  end

  test "it priorizes atom over string key" do
    rules = [
      type: :map,
      atomize: true,
      map: %{
        :key => [type: :string]
      }
    ]

    input = %{"key" => "string key value", :key => "atom key value"}

    assert Validate.validate(input, rules) == success(%{:key => "atom key value"})
  end
end
