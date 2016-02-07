defmodule JSONAPI.Serializer do
  @doc false
  defmacro __using__(_opts) do
    quote do
      import JSONAPI.Serializer

      def serialize(resource, opts \\ [])

      def serialize(resources, opts) when is_list(resources) do
        doc = build_doc(opts)
        %{data: Enum.map(resources, &serialize_resource(doc, &1))}
      end

      def serialize(resource, opts) do
        doc = build_doc(opts)
        %{data: serialize_resource(doc, resource)}
      end

      defp serialize_resource(doc, model) do
        %{}
        |> Map.merge(%{type: type(), id: model.id})
        |> Map.put(:attributes, Map.take(model, attributes()))
        |> Map.put(:links, links(model))
        |> Map.put(:relationships, process_relationships(doc, model))
      end

      defp process_relationships(doc, model) do
        Enum.reduce(relationships(), %{}, fn(rel, acc) ->
          include = Enum.any?(doc.config.includes, fn(include) ->
            rel.name == include
          end)

          if include do
            data = %{type: "authors", id: Map.get(model, rel.name).id}
            Map.put(acc, rel.name, %{data: data})
          else
            Map.put(acc, rel.name, %{})
          end
        end)
      end

      defp build_doc(%{include: include}) do
        includes = parse_include(include)

        %{config: %{includes: includes}}
      end

      defp build_doc(_) do
        config = %{config: %{includes: []}}
        document = JSONAPI.Document.new(
      end

      defp parse_include(""), do: []
      defp parse_include(include) do
        String.split(include || "", ",")
        |> Enum.map(&String.to_atom/1)
      end
    end
  end
end
