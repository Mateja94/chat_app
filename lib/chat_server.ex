defmodule ChatApp.ChatServer do
  @name :chat_server

  use GenServer
  alias ChatApp.Message

  defmodule State do
    defstruct count: 0, messages: []
  end

  # Client Interface

  def start do
    IO.puts("Starting the chat server...")
    GenServer.start(__MODULE__, %State{}, name: @name)
  end

  def send_message(text) do
    GenServer.call(@name, {:send_message, text})
  end

  def receive_message(text) do
    GenServer.call(@name, {:receive_message, text})
  end

  def show_messages() do
    GenServer.call(@name, {:show_messages})
  end

  # Server Callbacks

  def init(state) do
    {:ok, state}
  end

  def handle_call({:send_message, text}, _from, state) do
    message = Message.create(state.count + 1, :sent, text)
    new_state = %{state | count: state.count + 1, messages: state.messages ++ [message]}

    {:reply, new_state.count, new_state}
  end

  def handle_call({:receive_message, text}, _from, state) do
    message = Message.create(state.count + 1, :receive, text)
    new_state = %{state | count: state.count + 1, messages: state.messages ++ [message]}

    {:reply, new_state.count, new_state}
  end

  def handle_call({:show_messages}, _from, state) do
    {:reply, state.messages, state}
  end
end
