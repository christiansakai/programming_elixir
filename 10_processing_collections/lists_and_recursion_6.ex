defmodule MyList do
  def flatten(list) do
    _flatten(list, [])
  end

  defp _flatten(arg, new_list) when is_list(arg) == false do
    IO.puts "this is new list"
    IO.inspect new_list
    IO.inspect arg
    IO.puts "up there is elemnet"
    new_list ++ [arg]
  end

  defp _flatten([h | t], new_list) do
    _flatten(t, new_list ++ [h])
  end
end

IO.inspect MyList.flatten([1, [2, 3, [4]]])
