defmodule ChatApp do
  use Application
  require Logger

  alias ChatApp.ChatServer

  def start(_type, _args) do
    children = [
      {Plug.Adapters.Cowboy2, scheme: :http, plug: ChatApp.Router, options: [port: 8000]}
    ]

    ChatServer.start()

    Logger.info("App Started!!!")

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
