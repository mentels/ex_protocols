defmodule Protos.Twitter.APIMock do
  alias Protos.Twitter

  @behaviour Twitter.API

  @impl true
  def register(username) when is_binary(username) do
    :ok
  end

  @impl true
  def get_by_username(username) when is_binary(username) do
    %Twitter.User{username: username}
  end
end
