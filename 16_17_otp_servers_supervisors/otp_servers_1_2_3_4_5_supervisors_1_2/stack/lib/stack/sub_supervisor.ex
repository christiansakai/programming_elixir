defmodule Stack.SubSupervisor do
  @moduledoc """
  This is a sub supervisor to supervise
  stack worker process.
  """
  use Supervisor

  @doc """
  Start a supervisor. Pass a stash pid
  inside.
  """
  
  @spec start_link(pid) :: {:ok, pid}
  def start_link(stash_pid) do
    Supervisor.start_link(__MODULE__, stash_pid)
  end

  @doc """
  Will be called by start_link above.
  Basically it will spawn a new stack worker
  and giving it stash pid as argument.
  Supervise this worker.
  """

  def init(stash_pid) do
    stack_workers = [
      worker(Stack.Worker, [stash_pid])
    ]

    supervise(stack_workers, strategy: :one_for_one)
  end
end
