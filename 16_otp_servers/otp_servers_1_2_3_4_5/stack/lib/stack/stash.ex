defmodule Stack.Stash do
  use GenServer

  #####
  # External API
  def start_link(todolist) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, todolist)
  end

  def save_list(stash_pid, todolist)do
    GenServer.cast(stash_pid, {:save_list, todolist})
  end

  def get_list(stash_pid) do
    GenServer.call(stash_pid, :get_list)
  end

  #####
  # GenServer implementation
  def handle_cast({:save_list, todolist}, _current_todolist) do
    {:noreply, todolist}
  end

  def handle_call(:get_list, _from, current_todolist) do
    {:reply, current_todolist, current_todolist}
  end
end
