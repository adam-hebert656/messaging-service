defmodule MessagingService.Providers.Mms do
  alias MessagingService.MockClients.MmsClientMock

  def send(%{
        "body" => body,
        "to" => to_number,
        "from" => from_number,
        "attachments" => attachments
      }) do
    resp = MmsClientMock.create(to_number, from_number, body, attachments)

    case resp do
      {:ok, _} -> {:ok, :sent}
      {:error, reason} -> {:error, reason}
    end
  end
end
