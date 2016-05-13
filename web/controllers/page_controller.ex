defmodule Opencast.PageController do
  use Opencast.Web, :controller

  def index(conn, _params) do
    html(conn, Opencast.UI.fetch_index_html!)
  end
end
