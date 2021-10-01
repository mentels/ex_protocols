defmodule Protos.Twitter.API.Behaviour do
  alias Protos.Twitter

  @callback register(username :: String.t()) :: :ok | :already_taken
  @callback get_by_username(username :: String.t()) :: %Twitter.User{}
end
