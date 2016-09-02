ascii? = fn char_list ->
  Enum.all?(char_list, fn char ->
    char in ?\s..?~
  end)
end

IO.inspect ascii?.('hello')
