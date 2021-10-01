defmodule Protos.Twitter.StatelessTest do
  use ExUnit.Case

  alias Protos.Twitter.User
  alias Protos.Twitter.API.Behaviour, as: TwitterAPI
  alias Protos.Twitter.Stub.Stateless, as: Stub

  Mox.defmock(TwitterMock, for: Protos.Twitter.API.Behaviour)
  import Mox, only: [verify_on_exit!: 1]
  setup :verify_on_exit!

  test "explicitly implemented mocks does not have state" do
    impl = TwitterAPI.new(Stub)
    # we'd expect nil as the user was not registerd
    refute nil == TwitterAPI.get_by_username(impl, "ala")

    # we'd expect user already_takes as "ela" got registered
    assert :ok = TwitterAPI.register(impl, "ela")
    assert %User{username: "ela"} == TwitterAPI.get_by_username(impl, "ela")
    refute :already_taken == TwitterAPI.register(impl, "ela")
  end

  test "it's difficult to mimic state with mocks and expectations" do
    # Mox.defmock(TwitterMock, ...) called in the test_helper.exs, otherwise
    # undefined module warning
    #
    # to better mimic state we could use a reference to a PID (non-global mutable state)
    # or access a global state (named process, ETS, persistent term)
    impl = TwitterAPI.new(TwitterMock)

    Mox.expect(TwitterMock, :get_by_username, fn _ -> nil end)
    assert nil == TwitterAPI.get_by_username(impl, "ala")

    Mox.expect(TwitterMock, :register, fn "ela" -> :ok end)
    Mox.expect(TwitterMock, :get_by_username, fn "ela" -> %User{username: "ela"} end)
    Mox.expect(TwitterMock, :register, fn "ela" -> :already_taken end)
    assert :ok = TwitterAPI.register(impl, "ela")
    assert %User{username: "ela"} == TwitterAPI.get_by_username(impl, "ela")
    assert :already_taken == TwitterAPI.register(impl, "ela")
  end
end
