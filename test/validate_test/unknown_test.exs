defmodule ValidateTest.UnknownTest do
  use ExUnit.Case

  test "it does not validate when unwanted key is present with unknown reject" do
    rules = [
      type: :map,
      unknown: :reject,
      map: %{
      }
    ]

    input = %{
      "name" => "hi"
    }

    assert {:error, errors} = Validate.validate(input, rules)
    assert [%Validate.Validator.Error{path: [], message: "unknown keys: name", rule: :unknown}] = errors
  end

  test "it does not validate when unwanted key is present in map with unknown reject" do
    rules = [
      type: :map,
      unknown: :reject,
      map: %{
        name: [type: :map, unknown: :reject]
      }
    ]

    input = %{
      name: %{
        "phone" => "99"
      }
    }

    assert {:error, errors} = Validate.validate(input, rules)
    assert [%Validate.Validator.Error{path: [:name], message: "unknown keys: phone", rule: :unknown}] = errors
  end

  test "it does not validate when unwanted key is present in nested map with unknown reject" do
    rules = [
      type: :map,
      unknown: :reject,
      map: %{
        name: [type: :map, unknown: :reject, map: %{}]
      }
    ]

    input = %{
      name: %{
        "age" => "99",
        "phone" => "99",
      }
    }

    assert {:error, errors} = Validate.validate(input, rules)
    assert [%Validate.Validator.Error{path: [:name], message: "unknown keys: age, phone", rule: :unknown}] = errors
  end

  test "it does validate when key is string and atomize rule is on with unknown reject" do
    rules = [
      type: :map,
      atomize: true,
      unknown: :reject,
      map: %{
        name: []
      }
    ]

    input = %{
      "name" => "hi"
    }

    {:ok, result} = Validate.validate(input, rules)
    assert %{:name => "hi"} = result
    assert !Map.has_key?(result, "name")
  end

  test "it does validate when key is atom and atomize rule is on with unknown reject" do
    rules = [
      type: :map,
      atomize: true,
      unknown: :reject,
      map: %{
        name: []
      }
    ]

    input = %{
      name: "hi"
    }

    assert {:ok, %{ name: "hi" }} = Validate.validate(input, rules)
  end

  test "it does not validate when key is extra and atomize rule is on with unknown reject" do
    rules = [
      type: :map,
      atomize: true,
      unknown: :reject,
      map: %{
        name: []
      }
    ]

    input = %{
      "name" => "hi",
      "age" => "90"
    }

    assert {:error, errors} = Validate.validate(input, rules)
    assert [%Validate.Validator.Error{path: [], message: "unknown keys: age", rule: :unknown}] = errors
  end

  test "it does validate when unwanted key is present with unknown allow" do
    rules = [
      type: :map,
      map: %{
      },
      unknown: :allow
    ]

    input = %{
      "name" => "hi"
    }

    {:ok, %{"name" => "hi"}} = Validate.validate(input, rules)
  end

  test "it does validate when key is string and atomize rule is on with unknown allow" do
    rules = [
      type: :map,
      atomize: true,
      unknown: :allow,
      map: %{
        name: []
      }
    ]

    input = %{
      "name" => "hi"
    }

    {:ok, result} = Validate.validate(input, rules)
    assert %{:name => "hi"} = result
    assert !Map.has_key?(result, "name")
  end

  test "it does validate when key is atom and atomize rule is on with unknown allow" do
    rules = [
      type: :map,
      atomize: true,
      unknown: :allow,
      map: %{
        name: []
      }
    ]

    input = %{
      name: "hi"
    }

    assert {:ok, %{ name: "hi" }} = Validate.validate(input, rules)
  end

  test "it does validate when key is extra and atomize rule is on with unknown allow" do
    rules = [
      type: :map,
      atomize: true,
      map: %{
        name: []
      },
      unknown: :allow
    ]

    input = %{
      "name" => "hi",
      "age" => "90"
    }

    {:ok, result} = Validate.validate(input, rules)
    assert %{:name => "hi", "age" => "90"} = result
    assert !Map.has_key?(result, "name")
  end

  test "it does validate when key is extra and without atomize rule is on with unknown allow" do
    rules = [
      type: :map,
      map: %{
        name: []
      },
      unknown: :allow
    ]

    input = %{
      "name" => "hi",
      "age" => "90"
    }

    {:ok, result} = Validate.validate(input, rules)
    assert %{:name => nil, "name" => "hi", "age" => "90"} = result
  end

  test "it does validate when unwanted key is present with unknown remove" do
    rules = [
      type: :map,
      unknown: :remove,
      map: %{
      }
    ]

    input = %{
      "name" => "hi"
    }

    {:ok, result} = Validate.validate(input, rules)
    assert %{} = result
    assert !Map.has_key?(result, "name")
  end

  test "it does validate when key is string and atomize rule is on with unknown remove" do
    rules = [
      type: :map,
      atomize: true,
      unknown: :remove,
      map: %{
        name: []
      }
    ]

    input = %{
      "name" => "hi"
    }

    {:ok, result} = Validate.validate(input, rules)
    assert %{:name => "hi"} = result
    assert !Map.has_key?(result, "name")
  end

  test "it does validate when key is atom and atomize rule is on with unknown remove" do
    rules = [
      type: :map,
      atomize: true,
      unknown: :remove,
      map: %{
        name: []
      }
    ]

    input = %{
      name: "hi"
    }

    assert {:ok, %{ name: "hi" }} = Validate.validate(input, rules)
  end

  test "it does validate when key is extra and atomize rule is on with unknown remove" do
    rules = [
      type: :map,
      atomize: true,
      unknown: :remove,
      map: %{
        name: []
      }
    ]

    input = %{
      "name" => "hi",
      "age" => "90"
    }

    {:ok, result} = Validate.validate(input, rules)
    assert %{:name => "hi"} = result
    assert !Map.has_key?(result, "name")
    assert !Map.has_key?(result, "age")
  end
end
