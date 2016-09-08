ExUnit.start()

defmodule ProtocolsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "Caesar" do
    test "for charlist" do
      assert Caesar.encrypt('abc', 2) == 'cde' 
      assert Caesar.rot13('abc') == 'nop'
    end

    test "for string" do
      assert Caesar.encrypt("abc", 2) == "cde"
      assert Caesar.rot13("abc") == "nop"
    end
  end

  describe "Caesar usage" do
    test "apply caesar to wordlist" do
      assert LookThirteen.run("words") == %{
        3 => ["abc", "nop", "ape", "ncr"], 
        4 => ["fish", "svfu"],
        5 => ["tiger", "gvtre"], 
        6 => ["dragon", "qentba", "monkey", "zbaxrl"],
        8 => ["tortoise", "gbegbvfr", "supercar", "fhcrepne", "lighting", "yvtugvat"],
        13 => ["rollercoaster", "ebyyrepbnfgre"]
      }
     end
  end

  describe "MyEnum" do
    test "each" do
      assert capture_io(fn ->
        MyEnum.each([1, 2, 3], &IO.puts/1)
      end) == """
      1
      2
      3
      """

      assert MyEnum.each([1, 2, 3], &IO.puts/1) == :ok
    end

    test "filter" do
      assert MyEnum.filter([1, 2, 3, 4, 5], &(&1 > 3)) == [4, 5]
    end

    test "map" do
      assert MyEnum.map([1, 2, 3], &(&1 * 2)) == [2, 4, 6]
    end
  end
end
