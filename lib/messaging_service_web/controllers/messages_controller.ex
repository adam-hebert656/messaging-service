defmodule MessagingServiceWeb.MessagesController do
  use MessagingServiceWeb, :controller

  def send_message(conn, params) do
    IO.inspect(params)
    conn
    |> put_status(200)
    |> json(%{})
  end

  def receive_webhook_message(conn, params) do
    IO.inspect(params)
    conn
    |> put_status(200)
    |> json(%{})
  end
end
