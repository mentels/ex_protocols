defmodule Protos.Twitter.API.Behaviour do
  defstruct [:callback]

  alias Protos.Twitter

  @type t :: %__MODULE__{}
  @type username :: String.t()
  @type register_ret() :: :ok | :already_taken
  @type get_by_username_ret() :: %Twitter.User{}

  @callback register(username()) :: register_ret()
  @callback get_by_username(username()) :: get_by_username_ret()

  @spec new(Module.t()) :: t()
  def new(callback), do: %__MODULE__{callback: callback}

  @spec register(t(), username()) :: register_ret()
  def register(%__MODULE__{callback: callback}, username), do: callback.register(username)

  @spec get_by_username(t(), username()) :: get_by_username_ret()
  def get_by_username(%__MODULE__{callback: callback}, username),
    do: callback.get_by_username(username)
end
