defmodule ApiWeb.ApiSpec do
  @moduledoc """
  The API Spec
  """
  alias OpenApiSpex.{Info, OpenApi, Paths, Server}
  alias ApiWeb.{Endpoint, Router}
  @behaviour OpenApi

  @impl OpenApi
  @spec spec :: OpenApiSpex.OpenApi.t()
  def spec do
    %OpenApi{
      servers: [
        # Populate the Server info from a phoenix endpoint
        Server.from_endpoint(Endpoint)
      ],
      info: %Info{
        title: "API",
        version: "1.0.0"
      },
      # populate the paths from a phoenix router
      paths: Paths.from_router(Router)
    }
    # discover request/response schemas from path specs
    |> OpenApiSpex.resolve_schema_modules()
  end
end
