defmodule JSONAPI.Util do
  def dasherize(data) when is_atom(data), do: dasherize(Atom.to_string(data))
  def dasherize(data), do: String.replace(data, "_", "-")
end
