defmodule ChatApp.Message do
  alias ChatApp.Message

  defstruct id: nil, type: nil, text: nil

  def create(id, type, text) do
    %Message{id: id, type: type, text: text}
  end
end
