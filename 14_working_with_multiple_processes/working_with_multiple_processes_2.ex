# Spawns two processes and pass each other a unique token
defmodule Token do
  def other_process_receive do
    receive do
      {pid, token} ->
        send pid, {:ok, token}
    end
  end

  def self_process_receive do
    receive do
      {:ok, token} ->
        IO.puts token
        self_process_receive
    after 500 ->
        IO.puts "No more messages"
    end
  end
end

pid_one = spawn(Token, :other_process_receive, [])
send pid_one, {self, "Fred"}

pid_two = spawn(Token, :other_process_receive, [])
send pid_two, {self, "Betty"}

