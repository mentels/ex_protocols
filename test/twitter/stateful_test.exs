defmodule Protos.Twitter.StatefulTest do
  use ExUnit.Case

  alias Protos.Twitter.API.Protocol, as: TwitterAPI
  alias Protos.Twitter.Stub.Proc
  alias Protos.Twitter.Stub.ETS
  alias Protos.Twitter.User

  @implementations [ETS, Proc]

  for mod <- @implementations do
    describe "#{inspect mod} stub" do
      setup do
        %{impl: unquote(mod).new()}
      end

      test "register/2 registers a user", %{impl: impl} do
        assert :ok = TwitterAPI.register(impl, "ala")
      end

      test "register/2 doesn't allow to register the same user twice", %{impl: impl} do
        :ok = TwitterAPI.register(impl, "ala")
        assert :already_taken = TwitterAPI.register(impl, "ala")
      end

      test "get_by_username/2 returns nil for an unknown user", %{impl: impl} do
        refute TwitterAPI.get_by_username(impl, "ala")
      end

      test "get_by_username/2 returns previously registered user", %{impl: impl} do
        :ok = TwitterAPI.register(impl, "ala")
        assert %User{username: "ala"} = TwitterAPI.get_by_username(impl, "ala")
      end
    end
  end
end
