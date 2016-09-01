defmodule Opencast.UI do
  def fetch_index_html! do
    Redix.command!(:redix, ~w(GET opencast:index:current-content))
  end
end
