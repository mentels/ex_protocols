defmodule Protos.Twitter.APIMockTest do
  use ExUnit.Case

  alias Protos.Twitter.User
  alias Protos.Twitter.APIMock, as: Mock

  import Mox, only: [verify_on_exit!: 1]
  setup :verify_on_exit!

  test "explicitly implemented mocks does not have state" do
    # we'd expect nil as the user was not registerd
    refute nil == Mock.get_by_username("ala")

    # we'd expect user already_takes as "ela" got registered
    assert :ok = Mock.register("ela")
    assert %User{username: "ela"} == Mock.get_by_username("ela")
    refute :already_taken == Mock.register("ela")
  end

  test "it's difficult to mimic state with mocks and expectations" do
    # Mox.defmock(TwitterMock, ...) called in the test_helper.exs, otherwise
    # warning on undefined module
    #
    # to better mimic state we could use a reference to a PID (non-global mutable state)
    # or access a global state (named process, ETS, persistent term)
    Mox.expect(TwitterMock, :get_by_username, fn _ -> nil end)
    assert nil == TwitterMock.get_by_username("ala")

    Mox.expect(TwitterMock, :register, fn "ela" -> :ok end)
    Mox.expect(TwitterMock, :get_by_username, fn "ela" -> %User{username: "ela"} end)
    Mox.expect(TwitterMock, :register, fn "ela" -> :already_taken end)
    assert :ok = TwitterMock.register("ela")
    assert %User{username: "ela"} == TwitterMock.get_by_username("ela")
    assert :already_taken == TwitterMock.register("ela")
  end
end
