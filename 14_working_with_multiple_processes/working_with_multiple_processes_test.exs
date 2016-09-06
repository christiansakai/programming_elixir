ExUnit.start()

defmodule WorkingWithMultipleProcessesTest do
  use ExUnit.Case

  describe "Token" do
    test "send token" do
      fred_process = spawn(Token, :other_process_receive, [])
      send fred_process, {self, "fred"}

      betty_process = spawn(Token, :other_process_receive, [])
      send betty_process, {self, "betty"}

      assert_receive {^fred_process, "fred"}
      assert_receive {^betty_process, "betty"}

      Token.self_process_receive()
    end
  end
end
