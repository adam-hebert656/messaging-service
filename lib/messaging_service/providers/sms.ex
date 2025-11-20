defmodule MessagingService.Providers.Sms do
  alias MessagingService.MockClients.SmsClientMock

  def send(%{"body" => body, "to" => to_number, "from" => from_number}) do
    resp = SmsClientMock.create(to_number, from_number, body)

    case resp do
      {:ok, _} -> {:ok, :sent}
      {:error, reason} -> {:error, reason}
    end
  end
end
