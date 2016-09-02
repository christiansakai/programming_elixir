defmodule Sequence.Stash do
  use GenServer

  #####
  # External API
  def start_link(current_number) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, current_number)
  end

  def save_value(stash_pid, value) do
    GenServer.cast(stash_pid, {:save_value, value})
  end

  def save_delta(stash_pid, delta) do
  end

  def get_value(stash_pid) do
    GenServer.call(stash_pid, :get_value)
  end

  #####
  # GenServer implementation
  def handle_call(:get_value, _from, current_value) do
    {:reply, current_value, current_value}
  end

  def handle_cast({:save_value, value}, _current_value) do
    {:noreply, value}
  end

end
