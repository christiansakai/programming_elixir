defmodule StackTest do
  use ExUnit.Case

  alias Stack.Worker

  test "all the processes works" do
    assert Worker.contents() === []

    Worker.push(3)
    Worker.push(2)
    Worker.push(1)

    assert Worker.contents() == [1, 2, 3]

    assert Worker.pop() == 1
    assert Worker.pop() == 2
    assert Worker.pop() == 3

    assert Worker.contents() == []
  end
end
