defmodule JSONAPI.SerializerTest do
  use ExUnit.Case

  defmodule Article do
    defstruct [:id, :title, :body, :author]
  end

  defmodule Author do
    defstruct [:id, :first_name, :last_name]
  end

  defmodule ArticleSerializer do
    use JSONAPI.Serializer

    def type, do: "articles"

    def links(article) do
      %{self: "/api/v1/articles/#{article.id}"}
    end

    def attributes do
      [:title, :body, :author_name]
    end

    def relationships do
      [%{name: :author, cardinality: :one}]
    end
  end

  test "serialize has type field" do
    article = %Article{id: 123}
    serialized = ArticleSerializer.serialize(article)
    assert serialized.data.type == "articles"
  end

  test "serialize has id field" do
    article = %Article{id: 123}
    serialized = ArticleSerializer.serialize(article)
    assert serialized.data.id == 123
  end

  test "serialize has top-level links object" do
    article = %Article{id: 123}
    serialized = ArticleSerializer.serialize(article)
    assert serialized.data.links == %{self: "/api/v1/articles/123"}
  end

  test "serialize has resource attributes" do
    article = %Article{title: "Rails is Omakase", body: "So good, it's great!"}
    serialized = ArticleSerializer.serialize(article)
    assert serialized.data.attributes == %{
      title: "Rails is Omakase",
      body: "So good, it's great!"
    }
  end

  test "serialize has_one relationship" do
    article = %Article{title: "Rails is Omakase", body: "So good, it's great!"}
    serialized = ArticleSerializer.serialize(article)
    assert serialized.data.relationships == %{
      author: %{}
    }
  end

  test "serialize has_one relationship with included data" do
    author = %Author{id: 456, first_name: "Eric"}
    article = %Article{id: 123, author: author}
    serialized = ArticleSerializer.serialize(article, %{include: "author"})
    assert serialized.data.relationships == %{
      author: %{data: %{type: "authors", id: author.id}}
    }
  end
end
