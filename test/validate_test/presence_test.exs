defmodule ValidateTest.PresenceTest do
  use ExUnit.Case

  test "it does validate when key is not present in the map and is optional" do
    rules = [
      type: :map,
      map: %{
        name: [presence: :optional]
      }
    ]

    input = %{}

    assert {:ok, %{}} = Validate.validate(input, rules)
  end

  test "it does validate when key is not present in the map and no presence rule" do
    rules = [
      type: :map,
      map: %{
        name: []
      }
    ]

    input = %{}

    assert {:ok, %{name: nil}} = Validate.validate(input, rules)
  end

  test "it not does validate when key is not present in the map and is must" do
    rules = [
      type: :map,
      map: %{
        name: [presence: :must]
      }
    ]

    input = %{}

    assert {:error, errors} = Validate.validate(input, rules)
    assert [%Validate.Validator.Error{path: [:name], message: "must present", rule: :presence}] = errors
  end

  test "it does validate when key is present in the map and is must" do
    rules = [
      type: :map,
      map: %{
        name: [presence: :must]
      }
    ]

    input = %{ name: "value" }

    assert {:ok, %{name: "value"}} = Validate.validate(input, rules)
  end

  test "it does validate when key is present in the map and is optional" do
    rules = [
      type: :map,
      map: %{
        name: [presence: :must]
      }
    ]

    input = %{ name: "value" }

    assert {:ok, %{name: "value"}} = Validate.validate(input, rules)
  end

  test "it does validate when key is present in the map and no presence rule" do
    rules = [
      type: :map,
      map: %{
        name: []
      }
    ]

    input = %{ name: "value" }

    assert {:ok, %{name: "value"}} = Validate.validate(input, rules)
  end
end
