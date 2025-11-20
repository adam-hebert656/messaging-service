defmodule MessagingServiceWeb.ConversationsController do
  use MessagingServiceWeb, :controller

  alias MessagingService.Conversations

  def get_conversations(conn, _) do
    conversations = Conversations.get_all_conversations()

    conn
    |> put_status(200)
    |> json(conversations)
  end

  def get_messages_for_conversation(conn, %{"id" => id}) do
    messages =
      Conversations.get_conversation!(id)
      |> Map.get(:messages)

    conn
    |> put_status(200)
    |> json(messages)
  end
end
