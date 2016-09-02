defmodule Sequence.Supervisor do
  use Supervisor

  def start_link(initial_number) do
    result = Supervisor.start_link(__MODULE__, [])
    {:ok, supervisor_pid} = result
    
    start_worker(supervisor_pid, initial_number)

    result
  end

  def start_worker(supervisor_pid, initial_number) do
    stash_pid = start_stash_worker(supervisor_pid, initial_number)
    start_subsupervisor(supervisor_pid, stash_pid)
  end

  defp start_stash_worker(supervisor_pid, initial_number) do
    child_process = worker(Sequence.Stash, [initial_number])
    {:ok, stash_pid} = Supervisor.start_child(supervisor_pid, child_process)
    stash_pid
  end

  defp start_subsupervisor(supervisor_pid, stash_pid) do
    child_process = supervisor(Sequence.SubSupervisor, [stash_pid])
    {:ok, subsupervisor_pid} = Supervisor.start_child(supervisor_pid, child_process)
    subsupervisor_pid
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end
