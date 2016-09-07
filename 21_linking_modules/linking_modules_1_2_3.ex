defmodule Tracer do
  @moduledoc """
  Module to demonstrate use macro
  and overriding def macro from Kernel.
  """
  
  @doc """
  Return list of arguments in a string.

  ## Parameters
  - `args` - list of args

  ## Examples
      iex> Tracer.dump_args([1, 2, 3])
      "1, 2, 3"
  """
  @spec dump_args([number()]) :: binary()
  def dump_args(args) do
    args
    |> Enum.map(&inspect/1)
    |> Enum.join(", ")
  end

  @doc """
  Returns a string of function call
  with its arguments.

  ## Parameters
  - `name` - the function name
  - `args` - the arguments.

  ## Examples
      iex> Tracer.dump_defn("puts_sum_three", "1, 2, 3")
      "puts_sum_three(1, 2, 3)"
  """
  @spec dump_defn(binary(), binary()) :: binary()
  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  @doc """
  Replace the original def from the Kernel.
  This def has additional logs in it.
  
  The first definition is to take care of
  guard clauses. The second definition is to take
  care of the normal ones.
  """
  defmacro def(outer_def={:when, _, [_inner_def={name, _, args}, _guard_clause]}, do: content) do
    def_implementation(outer_def, name, args, content)
  end

  defmacro def(definition = {name, _, args}, do: content) do
    def_implementation(definition, name, args, content)
  end

  def def_implementation(definition, name, args, content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "call: #{unquote(__MODULE__).dump_defn(unquote(name), unquote(args))}"
        result = unquote(content)
        IO.puts "<== result: #{result}"
        result
      end
    end
  end

  @doc """
  use Tracer to import everything.
  """
  defmacro  __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end
end

defmodule Test do
  use Tracer

  # Define functions using modified `def`
  # by Tracer
  def puts_sum_three(a, b, c) when is_number(a) do 
    IO.inspect(a + b + c)
  end

  def add_list(list) do
    Enum.reduce(list, 0, &(&1 + &2))
  end

  def with_guard(a) when is_number(a) do
    a
  end
end
