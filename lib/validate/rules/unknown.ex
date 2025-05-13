defmodule Validate.Rules.Unknown do
  @moduledoc false

  import Validate.Validator

  def validate(%{value: value}) do
    success(value)
  end
end
