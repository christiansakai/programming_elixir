ExUnit.start()

defmodule MacrosAndCodeEvaluationTest do
  use ExUnit.Case
  require MyMacros.Explain
  import MyMacros

  test "myunless" do
    failure = myunless 1 + 1 == 2 do
      true
    else
      false
    end

    success = myunless 1 + 1 == 3 do
      true
    else
      false
    end

    assert failure == false
    assert success == true
  end

  test "times_n" do
    defmodule Helper do
      times_n(3)
      times_n(4)
    end

    assert Helper.times_3(2) == 6
    assert Helper.times_4(2) == 8
  end

  test "explain" do
    result = MyMacros.Explain.explain do 
      1 + 2
    end

    assert result == "ASDASD"
  end
end
