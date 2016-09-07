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
  """
  defmacro def(definition = {name, _, args}, do: content) do
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
