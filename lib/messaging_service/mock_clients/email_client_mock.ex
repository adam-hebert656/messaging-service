defmodule MessagingService.MockClients.EmailClientMock do
  def create(to, from, body, attachments \\ []) do
    try do
      IO.inspect("Mock Email sent to #{to} from #{from}: #{body}")
      IO.inspect("Attachments: #{inspect(attachments)}")
      {:ok, "queued"}
    rescue
      e -> {:error, e}
    end
  end
end
