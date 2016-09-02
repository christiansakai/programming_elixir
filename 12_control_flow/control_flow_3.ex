ok! = fn tuple ->
  case tuple do
    {:ok, data} -> data
    {:error, error} -> 
      raise "Error has happened #{error}"
  end
end

file = ok!.(File.open("control_flow_3.exs"))

IO.inspect file
