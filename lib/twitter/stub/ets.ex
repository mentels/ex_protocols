defmodule Protos.Twitter.Stub.ETS do
  defstruct [:tid]

  alias Protos.Twitter.User

  def new(opts \\ []) do
    tid = :ets.new(__MODULE__, [])
    %__MODULE__{tid: tid}
  end

  def register(%{tid: tid}, username) do
    case :ets.insert_new(tid, {username, %User{username: username}}) do
      true -> :ok
      false -> :already_taken
    end
  end

  def get_by_username(%{tid: tid}, username) do
    case :ets.lookup(tid, username) do
      [{^username, %User{} = user}] -> user
      [] -> nil
    end
  end
end
