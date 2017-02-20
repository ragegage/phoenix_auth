defmodule LoginApp.RoomChannel do
  use Phoenix.Channel

  def join("members_only", _message, socket) do
    {:ok, socket}
  end
  def join(_room, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end
end