defmodule Protos.Twitter.Stub.Stateful do
  defstruct [:pid]

  alias Protos.Twitter.User

  def new(opts \\ []) do
    {:ok, pid} = start_link(opts)
    %__MODULE__{pid: pid}
  end

  def start_link(_opts \\ []) do
    Agent.start_link(&Map.new/0)
  end

  def register(%{pid: pid}, username) do
    Agent.get_and_update(pid, fn
      %{^username => _user} = users ->
        {:already_taken, users}

      users ->
        {:ok, Map.put_new(users, username, %User{username: username})}
    end)
  end

  def get_by_username(%{pid: pid}, username) do
    Agent.get(pid, fn
      %{^username => user} -> user
      _ -> nil
    end)
  end
end
