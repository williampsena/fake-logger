defmodule FakeLogger.Producer do
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
