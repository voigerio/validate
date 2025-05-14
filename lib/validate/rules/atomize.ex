defmodule Validate.Rules.Atomize do
  @moduledoc false

  import Validate.Validator

  def validate(%{value: value, rules: rules}) do
    value =
      Enum.reduce(rules[:map], value, fn {key, _}, value ->
        if is_atom(key) do
          skey = Atom.to_string(key)

          if !Map.has_key?(value, key) && Map.has_key?(value, skey) do
            value
            |> Map.put(key, Map.get(value, skey))
            |> Map.delete(skey)
          else
            value
          end
        else
          value
        end
      end)

    success(value)
  end
end
