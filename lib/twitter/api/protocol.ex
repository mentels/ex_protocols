defprotocol Protos.Twitter.API.Protocol do
  @spec register(struct(), binary) :: :ok | :already_taken
  def register(impl, username)

  @spec register(struct(), binary) :: :ok | :already_taken
  def get_by_username(impl, username)
end
