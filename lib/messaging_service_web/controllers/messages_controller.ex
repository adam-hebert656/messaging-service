defmodule MessagingServiceWeb.MessagesController do
  use MessagingServiceWeb, :controller
  alias MessagingService.Messages

  def send_message(conn, params) do
    result = Messages.send_message(params["type"], params)

    case result do
      {:ok, _} ->
        conn
        |> put_status(200)
        |> json(%{})

      {:error, reason} ->
        conn
        |> put_status(200)
        |> json(%{})
    end
  end

  def ingest_webhook_message(conn, params) do
    IO.inspect(params)

    conn
    |> put_status(200)
    |> json(%{})
  end
end
