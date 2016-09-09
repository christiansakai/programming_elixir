defmodule Stack.Worker do
  @moduledoc """
  This is the main stack code.
  This process is supervised by
  sub supervisor.
  """
  use GenServer

  alias Stack.Stash

  #####
  # Public API

  @doc """
  Pop a value from the stack.
  """

  @spec pop() :: any()
  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  @spec contents() :: list
  def contents do
    GenServer.call(__MODULE__, :contents)
  end

  @spec push(any()) :: :ok
  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  #####
  # GenServer API

  @doc """
  Start the worker. Pass a stash pid
  so that this worker will remember a stash pid
  as part of the state.
  """

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  @doc """
  Make stash pid a part of the state.
  """

  def init(stash_pid) do
    list = Stash.load(stash_pid)
    {:ok, {list, stash_pid}}
  end

  def handle_call(:pop, _from, {list, stash_pid}) do
    [h | t] = list
    {:reply, h, {t, stash_pid}}
  end

  def handle_call(:contents, _from, state = {list, _stash_pid}) do
    {:reply, list, state}
  end

  def handle_cast({:push, item}, {list, stash_pid}) do
    {:noreply, {[item | list], stash_pid}}
  end

  def terminate(_reason, {list, stash_pid}) do
    Stash.save(stash_pid, list)
  end
end
