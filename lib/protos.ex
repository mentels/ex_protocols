defmodule Protos do
  @moduledoc """
  Documentation for `Protos`.
  """

  @behaviour Application

  alias Protos.Twitter.API, as: TwitterAPI

  @impl true
  def start(_, _) do
    Supervisor.start_link([{TwitterAPI, twitter_impl()}], strategy: :one_for_one)
  end

  @impl true
  def stop(_) do
    :ok
  end

  defp twitter_impl(),
    do: Application.get_env(:protos, :twitter_impl) || raise(":twitter_impl must be set")
end
