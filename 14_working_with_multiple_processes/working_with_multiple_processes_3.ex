defmodule Link do
  @moduledoc """
  This is to demonstrate whether if we kill a process
  the message that was sent by the process still received
  by the parent or not.
  """

  @doc """
  Run the example.
  """
  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Link, :notify_parent, [self])
    :timer.sleep(500)
    receive_messages
  end

  @doc """
  Send message to parent process
  and exit that process
  """
  def notify_parent(parent) do
    send parent, "Hello, World!"
    exit(:boom)
  end

  @doc """
  Receive message from other process.
  If it doesn't receive it in 500 seconds, kill itself
  """
  def receive_messages do
    receive do
      message ->
        IO.puts "Got #{inspect message}"
    after 500 ->
      IO.puts "It seems there's nothing more to do."
      exit(:ok)
    end
  end
end
