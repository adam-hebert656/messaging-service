defmodule MessagingService.MockClients.MmsClientMock do
  def create(to, from, body, attachments \\ []) do
    try do
      {:ok, "queued"}
    rescue
      e -> {:error, e}
    end
  end
end
