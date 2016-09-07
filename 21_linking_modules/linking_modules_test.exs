ExUnit.start()

defmodule LinkingModulesTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test ".puts_sum_three" do
    assert capture_io(fn ->
      Test.puts_sum_three(1, 2, 3)
    end) == """
    call: puts_sum_three(1, 2, 3)
    6
    <== result: 6
    """
  end

  test ".add_list" do
    assert capture_io(fn ->
      Test.add_list([5, 6, 7])
    end) == """
    call: add_list([5, 6, 7])
    <== result: 18
    """
  end

  test "with guard clauses" do
    assert catch_error(Test.with_guard("b")) == :function_clause
  end
end
