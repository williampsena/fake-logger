defmodule FakeLogger.MixProject do
  use Mix.Project

  def project do
    [
      app: :fake_logger,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        fake_logger: [
          include_executables_for: [:unix],
          applications: [runtime_tools: :permanent]
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    run_application(Mix.env())
  end

  def run_application(:test), do: extra_applications()

  def run_application(_), do: [mod: {FakeLogger, []}] ++ extra_applications()

  def extra_applications do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:faker, "~> 0.17"},
      {:gen_stage, "~> 1.2.1"}
    ]
  end
end
