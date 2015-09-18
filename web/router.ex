defmodule PhoenixDiff.Router do
  use PhoenixDiff.Web, :router

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

  scope "/", PhoenixDiff do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api/v1", PhoenixDiff.API.V1 do
    pipe_through :api

    get "/diff", DiffController, :index
  end
end
