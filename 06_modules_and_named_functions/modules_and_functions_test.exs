ExUnit.start()

defmodule TimesTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  doctest Times
  doctest Recursive

  test "test chop guess function" do
    assert capture_io(fn ->
      Chop.guess(273, 1..1000)
    end) == """
    Is it 500?
    Is it 250?
    Is it 375?
    Is it 312?
    Is it 281?
    Is it 265?
    Is it 273?
    Yes, it's 273
    """
  end
end
