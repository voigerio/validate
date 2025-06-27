defmodule ValidateTest.OptionalTest do
  use ExUnit.Case

  test "it does validate when key is not present in the map and is optional" do
    rules = [
      type: :map,
      map: %{
        name: [optional: true]
      }
    ]

    input = %{}

    assert {:ok, %{}} = Validate.validate(input, rules)
  end

  test "it does validate when key is not present in the map and is not optional" do
    rules = [
      type: :map,
      map: %{
        name: []
      }
    ]

    input = %{}

    assert {:ok, %{name: nil}} = Validate.validate(input, rules)
  end

  test "it does not validate when key is not present in the map and is not optional and required" do
    rules = [
      type: :map,
      map: %{
        name: [required: true]
      }
    ]

    input = %{}

    assert {:error, errors} = Validate.validate(input, rules)
    assert Enum.count(errors) == 1
  end

  test "it does validate when key is present in the map and is optional" do
    rules = [
      type: :map,
      map: %{
        name: [optional: true]
      }
    ]

    input = %{name: "value"}

    assert {:ok, %{name: "value"}} = Validate.validate(input, rules)
  end
end
