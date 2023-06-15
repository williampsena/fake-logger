defmodule FakeLogger.Consumer do
  use GenStage

  def start_link(_initial) do
    GenStage.start_link(__MODULE__, :running)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [FakeLogger.Producer]}
  end

  def handle_events(messages, _from, _state) do
    for message <- messages do
      FakeLogger.Message.print(message)
      :timer.sleep(delay_time())
    end

    {:noreply, [], :skip}
  end

  defp delay_time, do: Application.get_env(:fake_logger, :delay)
end
