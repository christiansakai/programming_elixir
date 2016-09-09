defmodule Stack.MainSupervisor do
  @moduledoc """
  Main supervisor that supervise a stash
  and a sub supervisor.
  """
  use Supervisor

  @doc """
  Start this main level supervisor with initial
  value of stack. 
  """

  @spec start_link(list) :: {:ok, pid}
  def start_link(initial_stack) do
    {:ok, supervisor_pid} = 
      Supervisor.start_link(__MODULE__, [])

    start_workers(supervisor_pid, initial_stack)
  end

  @doc """
  This will be called by start_link above. 
  Supervise an empty worker pool (because
  start_worker is where the workers are spawned
  instead).
  """
  def init(_) do
    supervise([], strategy: :one_for_one)
  end

  @doc """
  This starts all the workers necessary which are
  stash worker, and sub supervisor.
  """
  @spec start_workers(pid, list) :: {:ok, pid}
  def start_workers(supervisor_pid, initial_stack) do
    stash_worker = worker(Stack.Stash, [initial_stack])
    {:ok, stash_pid} = 
      Supervisor.start_child(supervisor_pid, stash_worker)

    stack_sub_supervisor = supervisor(Stack.SubSupervisor, [stash_pid])
    Supervisor.start_child(supervisor_pid, stack_sub_supervisor)
  end
end
