defmodule LoginApp.Router do
  use LoginApp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug LoginApp.CurrentUser
    plug :put_user_token
  end

  pipeline :login_required do
    plug Guardian.Plug.EnsureAuthenticated,
        handler: LoginApp.GuardianErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LoginApp do
    pipe_through [:browser, :with_session] # adds session to normal browser pipeline

    get "/", SessionController, :new

    resources "/users", UserController, only: [:show, :new, :create]

    resources "/sessions", SessionController, only: [:new, :create, :delete]

    scope "/" do
      pipe_through [:login_required]
      
      get "/chat", PageController, :index
    end
  end

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", LoginApp do
  #   pipe_through :api
  # end
end
