ExUnit.start()

defmodule MySigilTest do
  use ExUnit.Case

  import MySigil

  test "v sigil" do
    assert ~v"""
    1,2,3
    cat,dog
    """ === [["1", "2", "3"], ["cat", "dog"]]
  end

  test "v sigil with float" do
    assert ~v"""
    1,2,3.14
    cat,dog
    """p === [[1.0, 2.0, 3.14], ["cat", "dog"]]
  end

  test "v sigil with table" do
    assert ~v"""
    Item,Qty,Price
    Teddy bear,4,34.95
    Milk,1,2.99
    Battery,6,8.00
    """t == [
      [Item: "Teddy bear", Qty: "4", Price: "34.95"],
      [Item: "Milk", Qty: "1", Price: "2.99"],
      [Item: "Battery", Qty: "6", Price: "8.00"]
    ]
  end
end
