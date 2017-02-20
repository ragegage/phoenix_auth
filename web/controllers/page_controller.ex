defmodule LoginApp.PageController do
  use LoginApp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
