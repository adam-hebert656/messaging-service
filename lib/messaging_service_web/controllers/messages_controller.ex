defmodule MessagingServiceWeb.MessagesController do
  use MessagingServiceWeb, :controller
  alias MessagingService.Messages

  def send_message(conn, params) do
    params =
      if Map.get(params, "type") == "sms" and Map.get(params, "attachments", nil) != nil do
        Map.put(params, "type", "mms")
      else
        params
      end

    case Messages.send_message(params["type"], params) do
      {:ok, message} ->
        conn
        |> put_status(200)
        |> json(message)

      {:error, reason} ->
        conn
        |> put_status(500)
        |> json(Map.from_struct(reason))
    end
  end

  def ingest_webhook_message(conn, params) do
    case Messages.ingest_message(params) do
      {:ok, message} ->
        conn
        |> put_status(200)
        |> json(message)

      {:error, reason} ->
        conn
        |> put_status(500)
        |> json(Map.from_struct(reason))
    end
  end
end
