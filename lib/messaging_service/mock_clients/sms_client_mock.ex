defmodule MessagingService.MockClients.SmsClientMock do
  def create(to, from, body, _attachments \\ []) do
    try do
      {:ok, "queued"}
    rescue
      e -> {:error, e}
    end
  end
end
