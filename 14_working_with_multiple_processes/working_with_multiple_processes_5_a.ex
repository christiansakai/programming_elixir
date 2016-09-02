defmodule Link do
  def run do
    spawn_monitor(Link, :notify_parent, [self])
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

Link.run
