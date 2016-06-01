defmodule JSONAPI.DocumentTest do
  use ExUnit.Case, async: true

  import JSONAPI.Document

  test "build/0: returns a new JSON API Document" do
    assert build == %JSONAPI.Document{}
  end
end
