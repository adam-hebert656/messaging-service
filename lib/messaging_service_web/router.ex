defmodule MessagingServiceWeb.Router do
  use MessagingServiceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MessagingServiceWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MessagingServiceWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", MessagingServiceWeb do
    post "/messages/:type", MessagesController, :send_message
    post "/webhooks/:type", MessagesController, :receive_webhook_message

    get "/conversations", ConversationsController, :get_conversations
    get "/conversations/:id/messages", ConversationsController, :get_messages_for_conversation
  end
end
