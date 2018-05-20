defmodule ChatApp.Router do
  use Plug.Router

  @templates_path Path.expand("../templates", __DIR__)

  alias ChatApp.ChatServer

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "world")
  end

  get "/send_message/:text" do
    messageId = ChatServer.send_message(text)

    send_resp(conn, 200, "Sent message with id #{messageId}!")
  end

  get "/receive_message/:text" do
    messageId = ChatServer.receive_message(text)

    send_resp(conn, 200, "Received message with id #{messageId}!")
  end

  get "/messages" do
    messages = ChatServer.show_messages()
    render(conn, "/messages.eex", messages: messages)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  defp render(conn, template, bindings \\ []) do
    content =
      @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)

    send_resp(conn, 200, content)
  end
end
