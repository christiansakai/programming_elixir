defmodule Token do
  @moduledoc """
  Demonstrate communicating between processes.
  """

  @doc """
  Make other process receive message.
  """
  def other_process_receive do
    receive do
      {pid, token} ->
        send pid, {self, token}
    end
  end

  @doc """
  Make this current process receive message.
  """
  def self_process_receive do
    receive do
      {from, token} ->
        IO.puts token
        self_process_receive
    after 500 ->
        IO.puts "No more messages"
    end
  end
end
