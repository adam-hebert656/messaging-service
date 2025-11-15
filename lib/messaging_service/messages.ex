defmodule MessagingService.Messages do

  def send_message("sms", message) do
    %{ "body" => body } = message
    IO.inspect("Sending SMS: #{body}")
    :ok
  end

  def send_message("mms", message) do
    %{ "body" => body } = message
    IO.inspect("Sending MMS: #{body}")
    :ok
  end

  def send_message("email", message) do
    %{ "body" => body } = message
    IO.inspect("Sending Email: #{body}")
    :ok
  end

  def send_message(_, _message) do
    IO.inspect("Unknown message type")
    :error
  end
end
