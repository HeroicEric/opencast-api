defmodule JSONAPI.ResourceObjectTest do
  use ExUnit.Case, async: true

  import JSONAPI.ResourceObject

  test "put_top_level/2: sets the type for the Resource Object" do
    resource = build |> put_top_level(%{type: "articles", id: 42})
    assert resource.type == "articles"
    assert resource.id == 42
  end

  test "put_attribute/3: adds value of single key from given data to attributes object" do
    data = %{title: "JSON API paints my bikeshed!"}
    resource = build |> put_attribute(data, :title)
    assert resource.attributes["title"] == "JSON API paints my bikeshed!"
  end

  test "put_attributes/3: adds value of multiple keys from given data to attributes object" do
    data = %{category: "Horror", title: "JSON API paints my bikeshed!"}
    resource = build |> put_attributes(data, [:category, :title])
    assert resource.attributes["title"] == "JSON API paints my bikeshed!"
    assert resource.attributes["category"] == "Horror"
  end
end
