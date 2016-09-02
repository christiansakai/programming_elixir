defmodule Stack.Server do
  use GenServer

  ####
  # Stack Implementation
  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  def get_list do
    GenServer.call(__MODULE__, :get_list)
  end

  ####
  # GenServer Implementation
  def init(stash_pid) do
    todolist = Stack.Stash.get_list(stash_pid)
    {:ok, {todolist, stash_pid}}
  end

  def handle_call(:pop, _from, {[h | t], stash_pid}) do
    {:reply, h, {t, stash_pid}}
  end

  def handle_call(:get_list, _from, {todolist, stash_pid}) do
    {:reply, todolist, {todolist, stash_pid}}
  end

  def handle_cast({:push, item}, {todolist, stash_pid}) do
    {:noreply, {[item | todolist], stash_pid}}
  end

  def terminate(_reason, {todolist, stash_pid}) do
    Stack.Stash.save_list(stash_pid, todolist)
  end
end


