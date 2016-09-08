defmodule Person do
  defstruct [name: nil, age: 0]

  def new(name, age) do
    %__MODULE__{name: name, age: age}
  end
end

defimpl Inspect, for Map do
  def inspect(map, _opts) do
  end
end
