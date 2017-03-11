defmodule LoginApp.RoomChannel do
  use Phoenix.Channel
  alias LoginApp.User
  alias LoginApp.Repo

  def join("members_only", _message, socket) do
    {:ok, socket}
  end
  def join(_room, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    user = Repo.get!(User, socket.assigns.user)
    broadcast! socket, "new_msg", %{body: body, user: user.email}
    {:noreply, socket}
  end
end