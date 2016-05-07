defmodule Audrey do
  def fetch(url) do
    case fetch_data(url) do
      {:ok, data} ->
        parse(data)
      {:error, error} ->
        {:error, error}
    end
  end

  def parse(xml) do
    {:ok, Audrey.Feed.parse(xml)}
  catch
    :exit, _ -> {:error, "expected element start tag"}
  end

  def parse!(xml) do
    case parse(xml) do
      {:ok, feed} -> feed
      {:error, error} -> raise error
    end
  end

  defp fetch_data(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      _ ->
        {:error, "Error fetching feed information for #{url} :("}
    end
  end
end
