defmodule MessagingService.MockClients.SmsClientMock do
  def create(to, from, body, _attachments \\ []) do
    try do
      IO.inspect("Mock SMS sent to #{to} from #{from}: #{body}")
      {:ok, "queued"}
    rescue
      e -> {:error, e}
    end
  end
end
