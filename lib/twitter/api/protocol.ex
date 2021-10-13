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
