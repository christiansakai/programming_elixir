defmodule Ticker do
  @interval 2000 
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[], []])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients, remaining_clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator([pid | clients], remaining_clients)
    after @interval ->
      IO.puts "tick"
      do_tick(clients, remaining_clients)
    end
  end

  defp do_tick([], []) do
    generator([], [])
  end

  defp do_tick([_head | _tail] = clients, []) do
    do_tick(clients, clients)
  end

  defp do_tick(clients, remaining_clients) do
    [client | remaining_clients] = remaining_clients
    send client, {:tick}
    generator(clients, remaining_clients)
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts "tock in client"
        receiver
    end
  end
end
