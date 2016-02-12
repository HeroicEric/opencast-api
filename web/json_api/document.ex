defmodule JSONAPI.Document do
  defstruct [:data, :errors, :meta, :links]

  def new do
    %JSONAPI.Document{}
  end

  def add_resource(%JSONAPI.Document{data: data} = document, resource) when is_map(data) do
    new_data = [data, resource]
    %JSONAPI.Document{document | data: new_data}
  end

  def add_resource(%JSONAPI.Document{data: data} = document, resource) when is_list(data) do
    new_data = [resource | data] |> Enum.reverse
    %JSONAPI.Document{document | data: new_data}
  end

  def add_resource(%JSONAPI.Document{} = document, resource) do
    %JSONAPI.Document{document | data: resource}
  end
end
