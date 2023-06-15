defmodule FakeLogger.CommandTest do
  use ExUnit.Case
  import ExUnit.CaptureLog

  doctest FakeLogger.Command

  describe "run/0" do
    test "should print message" do
      assert capture_log(&FakeLogger.Command.run/0) != ""
    end
  end
end
