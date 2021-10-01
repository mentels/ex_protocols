defmodule Protos.Twitter.StatefulTest do
  use ExUnit.Case

  alias Protos.Twitter.API.Protocol, as: TwitterAPI
  alias Protos.Twitter.Stub.Stateful, as: TwitterMock
  alias Protos.Twitter.User

  test "can maintain state" do
    impl = TwitterMock.new()

    assert :ok = TwitterAPI.register(impl, "ala")
    assert :already_taken = TwitterAPI.register(impl, "ala")

    assert %User{username: "ala"} = TwitterAPI.get_by_username(impl, "ala")
    refute TwitterAPI.get_by_username(impl, "ela")
  end
end
