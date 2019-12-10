defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug(OpenApiSpex.Plug.PutApiSpec, module: ApiWeb.ApiSpec)
  end

  scope "/api" do
    pipe_through :api

    get("/openapi", OpenApiSpex.Plug.RenderSpec, [])
    post("/carts", ApiWeb.CartsController, :create)
  end
end
