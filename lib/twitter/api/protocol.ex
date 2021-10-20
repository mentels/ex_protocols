defmodule Protos.Twitter.API do
  @moduledoc """
  Wrapper around the Twitter Client that keeps its state.
  """
  use GenServer

  # The behaviour turns out to be useful here as it allows to abstract the way
  # that we interact with Twitter from the actual Twitter client details.
  # However this example is not perfect as those 2 things are almost identical.
  @behaviour Protos.Twitter.API.Behaviour

  alias Protos.Twitter.API.Protocol

  @name __MODULE__

  ### API

  def start_link(impl), do: GenServer.start_link(__MODULE__, impl, name: @name)

  @impl Protos.Twitter.API.Behaviour
  def register(username), do: GenServer.call(@name, {:register, username})

  @impl Protos.Twitter.API.Behaviour
  def get_by_username(username), do: GenServer.call(@name, {:get_by_username, username})

  ### GenServer

  @impl GenServer
  def init(impl), do: {:ok, impl.new()}

  @impl GenServer
  def handle_call({:register, username}, _from, impl),
    do: {:reply, Protocol.register(impl, username), impl}

  @impl GenServer
  def handle_call({:get_by_username, username}, _from, impl),
    do: {:reply, Protocol.get_by_username(impl, username), impl}
end

defprotocol Protos.Twitter.API.Protocol do
  @spec register(struct(), binary) :: :ok | :already_taken
  def register(impl, username)

  @spec register(struct(), binary) :: :ok | :already_taken
  def get_by_username(impl, username)
end

defimpl Protos.Twitter.API.Protocol, for: Protos.Twitter.Stub.Proc do
  alias Protos.Twitter.Stub.Proc, as: Impl

  defdelegate register(impl, username), to: Impl
  defdelegate get_by_username(impl, username), to: Impl
end

defimpl Protos.Twitter.API.Protocol, for: Protos.Twitter.Stub.ETS do
  alias Protos.Twitter.Stub.ETS, as: Impl

  defdelegate register(impl, username), to: Impl
  defdelegate get_by_username(impl, username), to: Impl
end
