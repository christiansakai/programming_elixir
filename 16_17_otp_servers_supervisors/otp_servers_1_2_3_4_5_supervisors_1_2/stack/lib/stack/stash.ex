defmodule Stack.Stash do
  @moduledoc """
  Module to save stack. This is needed
  to save data in case a stack worker terminates.
  """
  use GenServer

  #####
  # Public API
  @doc """
  Save a stack to a stash process.
  """
  
  @spec save(pid, list) :: :ok
  def save(pid, stack) do
    GenServer.cast(pid, {:save, stack})
  end

  @doc """
  Load a stack from a stash process.
  """

  @spec load(pid) :: list
  def load(pid) do
    GenServer.call(pid, :load)
  end

  #####
  # GenServer API
  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack)
  end

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_cast({:save, stack}, _state) do
    {:noreply, stack}
  end

  def handle_call(:load, _from, state) do
    {:reply, state, state}
  end
end
