defmodule FakeLogger.Producer do
  @moduledoc """
  The module is in responsible for producing fake messages.
  """
  use GenStage

  def start_link(initial \\ []) do
    GenStage.start_link(__MODULE__, initial, name: __MODULE__)
  end

  def init(_), do: {:producer, :skip}

  def handle_demand(demand, _) do
    messages = Enum.map(0..(demand), fn _ -> FakeLogger.Message.build() end)
    {:noreply, messages, :skip}
  end
end
