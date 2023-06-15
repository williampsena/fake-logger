defmodule FakeLogger do
  @moduledoc """
  The module is in responsible for handle application processes.
  """
  use Application

  @doc """
  Start GenStage processes
  """
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      {FakeLogger.Producer, nil},
      {FakeLogger.Consumer, nil}
    ]

    opts = [strategy: :one_for_one, name: FakeLogger.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
