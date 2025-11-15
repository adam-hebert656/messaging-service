defmodule MessagingServiceWeb.ConversationsController do
  use MessagingServiceWeb, :controller

  def get_conversations(conn, params) do
    IO.inspect(params)

    conn
    |> put_status(200)
    |> json(%{})
  end

  def get_messages_for_conversation(conn, params) do
    IO.inspect(params)

    conn
    |> put_status(200)
    |> json(%{})
  end
end
