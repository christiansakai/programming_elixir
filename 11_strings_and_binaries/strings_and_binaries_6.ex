capitalize_sentences = fn str ->
  str
  |> String.split(". ")
  |> Enum.map(&String.capitalize/1)
  |> Enum.join(". ")
end


IO.puts capitalize_sentences.("oh. a DOG. woof. ")
