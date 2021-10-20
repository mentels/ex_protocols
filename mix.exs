defmodule Protos.MixProject do
  use Mix.Project

  def project do
    [
      app: :protos,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      config_path: "config/config.exs"
    ]
  end

  def application do
    [
      mod: {Protos, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mox, "~>1.0", only: :test},
      {:norm, "~>0.13"},
      {:stream_data, "~>0.5"},
      {:faker, "~>0.16"}
    ]
  end
end
