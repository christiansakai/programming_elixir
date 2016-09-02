defmodule Stack.Supervisor do
  use Supervisor

  def start_link(todolist) do
    result = Supervisor.start_link(__MODULE__, [])
    {:ok, supervisor_pid} = result

    start_workers(supervisor_pid, todolist)

    result
  end

  def start_workers(supervisor_id, todolist) do
    stash_pid = start_stash_worker(supervisor_id, todolist)
    start_subsupervisor(supervisor_id, stash_pid)
  end

  defp start_stash_worker(supervisor_id, todolist) do
    child_process = worker(Stack.Stash, [todolist])
    {:ok, stash_pid} = Supervisor.start_child(supervisor_id, child_process)
    stash_pid
  end

  defp start_subsupervisor(supervisor_id, stash_pid) do
    child_process = supervisor(Stack.SubSupervisor, [stash_pid])
    {:ok, subsupervisor_pid} = Supervisor.start_child(supervisor_id, child_process)
    subsupervisor_pid
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end
