defmodule MyTestsWeb.Router do
  use MyTestsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyTestsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/sop", SopController
    resources "/signup", UserController, only: [:create, :new]
    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-out", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyTestsWeb do
  #   pipe_through :api
  # end
end
