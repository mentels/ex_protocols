defmodule Protos.Twitter.Stub.Stateless do
  alias Protos.Twitter
  alias Protos.Twitter.API.Behaviour, as: TwitterAPI

  @behaviour TwitterAPI

  @impl true
  def register(username) when is_binary(username) do
    :ok
  end

  @impl true
  def get_by_username(username) when is_binary(username) do
    %Twitter.User{username: username}
  end
end
