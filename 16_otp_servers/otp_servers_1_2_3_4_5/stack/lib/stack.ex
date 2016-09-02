defmodule Stack do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    todolist = Application.get_env(:stack, :todolist)

    {:ok, _pid} = Stack.Supervisor.start_link(todolist)
  end
end
