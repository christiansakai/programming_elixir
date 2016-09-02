anagram? = fn word1, word2 ->
  Enum.sort(word1) === Enum.sort(word2)
end

IO.inspect anagram?.('cat', 'tac')
IO.inspect anagram?.('bat', 'tad')
