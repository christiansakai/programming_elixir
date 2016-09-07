defmodule FibSolver do
  @moduledoc """
  Module to demonstrate process oriented Elixir.
  This is different than previous Pmap because in the
  previous Pmap processes were short-lived and die 
  as soon as it accomplishes its task. 

  In this module, we spawn processes that stay alive
  waiting to be given task by the scheduler.

  The solver sends :ready, :answer atom to
  tell the scheduler that this particular solver
  is ready to be given task or to return back the answer. 
  """

  def fib(scheduler) do
    send scheduler, {:ready, self}

    receive do
      {:compute, job, scheduler} ->
        send scheduler, {:answer, job, fib_calc(job), self}
        fib(scheduler)

      :shutdown ->
        exit(:normal)
    end
  end

  # Deliberately without caching
  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n) do 
    fib_calc(n - 1) + fib_calc(n - 2)
  end
end

defmodule FibScheduler do
  @moduledoc """
  Module to demonstrate process oriented Elixir.
  This is different than previous Pmap because in the
  previous Pmap processes were short-lived and die 
  as soon as it accomplishes its task. 

  In this module, we spawn processes that stay alive
  waiting to be given task by the scheduler.

  The scheduler sends :compute, :shutdown atom to
  tell the solver to either compute or kill itself. 
  """

  def run(num_processes, module, fun, fib_until) do
    spawned_processes = 
      (1..num_processes)
      |> Enum.map(fn _ -> spawn(module, fun, [self]) end)

    schedule_processes(spawned_processes, fib_until, [])
  end

  defp schedule_processes(spawned_processes, fib_until_left, results) do
    receive do
      {:ready, child_process} when length(fib_until_left) > 0 ->
        [next_job | rest] =  fib_until_left
        send child_process, {:compute, next_job, self}
        schedule_processes(spawned_processes, rest, results)

      {:ready, child_process} ->
        send child_process, :shutdown

        if length(spawned_processes) > 1 do
          schedule_processes(List.delete(spawned_processes, child_process), fib_until_left, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end
      
      {:answer, number, result, _child_process} ->
        schedule_processes(spawned_processes, fib_until_left, [{number, result} | results])
    end
  end
end

fib_until = [37, 37, 37, 37, 37]
num_of_processes_spawned = 1..5

Enum.each num_of_processes_spawned, fn num_processes ->
  {time, result} = :timer.tc(
    FibScheduler, :run, [num_processes, FibSolver, :fib, fib_until]
  )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "|n#     time(s)"
  end

  :io.format("~2B     ~.2f~n", [num_processes, time / 1_000_000.0])
end
