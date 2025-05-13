defmodule Validate.Rules.Unknown do
  @moduledoc false

  import Validate.Validator

  # Dummy one to not panic with unknown validator not present.
  # We cannot fully rely upon this style like other validators
  # as the map value gets modified in cases like unknown: allow
  # which distracts the other validators.
  # Hence an explcit validator added on the validator.ex to handle
  # at the end of the map validation
  def validate(%{value: value}) do
    success(value)
  end
end
