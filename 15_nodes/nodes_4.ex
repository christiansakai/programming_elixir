defmodule Ring do
  
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients) when clients == [] do
    receive do
      { :register, pid } ->
        IO.puts "adding #{inspect pid} to the ring"
        send pid, { :client, pid }
        send pid, { :tick, "tick from #{inspect self}" }
        generator([pid|clients])
    end
  end
  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "adding #{inspect pid} to the ring"
        send pid, { :client, List.last(clients) }
        send List.first(clients), { :client, pid }
        generator([pid|clients])
    end
  end

end

defmodule Client do

  @interval 5000

  def start do
    pid = spawn(__MODULE__, :receiver, [nil])
    Ticker.register(pid)
  end

  def receiver(next_pid) do
    receive do
      { :tick, message } ->
        IO.puts message
        send_to_client(next_pid)
        receiver(next_pid)
      { :client, next_pid } ->
        receiver(next_pid)
    end
  end

  defp send_to_client(next_client) when next_client == nil, do: nil
  defp send_to_client(next_client) do 
    receive do
    after @interval ->
        send next_client, { :tick, "tick from #{inspect self}" }
    end
  end

end
