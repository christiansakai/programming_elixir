center = fn list ->
  longest = Enum.max_by(list, &String.length/1)
    |> String.length
  
  list
  |> Enum.map(fn animal ->
    pad = (longest - String.length(animal))
      |> div(2)

    String.duplicate(" ", pad) <> animal <> String.duplicate(" ", pad)
  end)
  |> Enum.each(&IO.puts/1)
end

center.(["cat", "zebra", "elephant"])
