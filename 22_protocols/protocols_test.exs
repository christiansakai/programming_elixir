ExUnit.start()

defmodule ProtocolsTest do
  use ExUnit.Case

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
end
