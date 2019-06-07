defmodule Audrey.Util do
  def format_value(value) do
    value |> String.strip() |> value_or_nil
  end

  def value_or_nil(""), do: nil
  def value_or_nil(value), do: value
end
