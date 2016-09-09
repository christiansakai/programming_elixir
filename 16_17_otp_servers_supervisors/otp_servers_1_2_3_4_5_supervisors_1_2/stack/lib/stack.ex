defmodule Stack do
  @moduledoc """
  Demonstrate OTP GenServer
  and Supervisor combo in a 
  supervision tree.
  """

  use Application

  @doc """
  Start the app with [] (empty 
  stack) as starting.
  """
  def start(_type, _args) do
    {:ok, _pid} = Stack.MainSupervisor.start_link([])
  end
end
