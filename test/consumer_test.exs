defmodule FakeLogger.ConsumerTest do
  use ExUnit.Case
  import ExUnit.CaptureLog

  alias FakeLogger.Consumer, as: FakeLoggerConsumer

  doctest FakeLoggerConsumer

  describe "init/0" do
    test "should initialize consumer" do
      assert FakeLoggerConsumer.init(nil) ==
               {:consumer, nil, [subscribe_to: [FakeLogger.Producer]]}
    end
  end

  describe "handle_events/3" do
    test "should print message" do
      messages = ["foo message"]

      assert capture_log(fn -> FakeLoggerConsumer.handle_events(messages, nil, nil) end) =~
               "foo message"
    end
  end
end
