ExUnit.start()

defmodule LinkingModulesTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  use Tracer

  # Define functions using modified `def`
  # by Tracer
  def puts_sum_three(a, b, c) do 
    IO.inspect(a + b + c)
  end

  def add_list(list) do
    Enum.reduce(list, 0, &(&1 + &2))
  end

  test ".puts_sum_three" do
    assert capture_io(fn ->
      puts_sum_three(1, 2, 3)
    end) == """
    call: puts_sum_three(1, 2, 3)
    6
    <== result: 6
    """
  end

  test ".add_list" do
    assert capture_io(fn ->
      add_list([5, 6, 7])
    end) == """
    call: add_list([5, 6, 7])
    <== result: 18
    """
  end
end
