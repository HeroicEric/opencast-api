defmodule JSONAPI.DocumentTest do
  use ExUnit.Case

  alias JSONAPI.Document

  test "constructor" do
    document = Document.new

    assert document.data == nil
    assert document.errors == nil
    assert document.meta == nil
    assert document.links == nil
  end

  test "adding a primary resource object" do
    resource = %{id: 123, type: "articles"}

    document =
      Document.new
      |> Document.add_resource(resource)

    assert document.data == resource
  end 

  test "adding a second resource object" do
    resources = [
      %{id: 123, type: "articles"},
      %{id: 456, type: "articles"}
    ]
    [resource1, resource2] = resources

    document =
      Document.new
      |> Document.add_resource(resource1)
      |> Document.add_resource(resource2)

    assert document.data == resources
  end

  test "adding a 3rd+ resource object" do
    resources = [
      %{id: 123, type: "articles"},
      %{id: 456, type: "articles"},
      %{id: 789, type: "articles"},
    ]
    [resource1, resource2, resource3] = resources

    document =
      Document.new
      |> Document.add_resource(resource1)
      |> Document.add_resource(resource2)
      |> Document.add_resource(resource3)

    assert document.data == resources
  end
end
