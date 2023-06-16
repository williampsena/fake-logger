defmodule FakeLogger.ProducerTest do
  use ExUnit.Case

  alias FakeLogger.Producer, as: FakeLoggerProducer

  doctest FakeLoggerProducer

  describe "init/0" do
    test "should initialize producer" do
      assert FakeLoggerProducer.init(nil) == {:producer, :skip}
    end
  end

  describe "handle_demand/2" do
    setup do
      demand = 10

      [demand: demand]
    end

    test "should some handle demand", %{demand: demand} do
      {:noreply, messages, :skip} = FakeLoggerProducer.handle_demand(demand, nil)

      assert Kernel.length(messages) == demand + 1
      assert Enum.all?(messages, &Kernel.is_bitstring/1)
    end
  end
end
