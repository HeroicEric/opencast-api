defmodule JSONAPI.ResourceObject do
  import JSONAPI.Util, only: [dasherize: 1]

  defstruct [:type, :id, attributes: %{}, relationships: %{}]

  def build, do: %JSONAPI.ResourceObject{}

  def put_top_level(%JSONAPI.ResourceObject{} = resource_object, %{type: type, id: id}) do
    resource_object
    |> Map.put(:type, type)
    |> Map.put(:id, id)
  end

  def put_attribute(resource_object, data, key) do
    new_attributes =
      resource_object
      |> Map.get(:attributes)
      |> Map.put(dasherize(key), Map.get(data, key))

    %{resource_object | attributes: new_attributes}
  end

  def put_attributes(resource_object, data, keys) do
    Enum.reduce(keys, resource_object, fn(key, res) ->
      put_attribute(res, data, key)
    end)
  end

  def put_has_many(resource_object, data, key) do
    new_relationships =
      resource_object
      |> Map.get(:relationships)
      |> Map.put(
        dasherize(key),
        %{
          links: %{
            related: "/podcasts/#{resource_object.id}/#{dasherize(key)}"
          }
        }
      )

    %{resource_object | relationships: new_relationships}
  end
end

