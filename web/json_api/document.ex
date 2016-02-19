defmodule JSONAPI.Document do
  defstruct [
    jsonapi: %{version: "1.0"},
    links: nil,
    data: nil
  ]

  def build, do: %JSONAPI.Document{}

  def put_primary_data(doc, data) when is_list(data) do
    Map.put(doc, :data, data)
  end

  def put_primary_data(doc, data) do
    Map.put(doc, :data, data)
  end
end
