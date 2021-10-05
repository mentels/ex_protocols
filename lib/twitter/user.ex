defmodule Protos.Twitter.User do
  defstruct [:username]

  require Norm

  def schema,
    do:
      Norm.schema(%__MODULE__{
        username: Norm.spec(is_binary())
      })

  def schema_faker do
    Norm.schema(%__MODULE__{
      username: Norm.with_gen(Norm.spec(is_binary()), generator)
    })
  end

  def generator() do
      :unused
      |> StreamData.constant()
      |> StreamData.bind(fn _ ->
        StreamData.constant(Faker.Internet.user_name())
      end)
      |> StreamData.unshrinkable()
  end
end
