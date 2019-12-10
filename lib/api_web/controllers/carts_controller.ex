defmodule ApiWeb.CartsController do
  use ApiWeb, :controller

  alias OpenApiSpex.Operation
  alias ApiWeb.Schemas.{Cart, CreateCartErrorResponse, CreateCartSuccessResponse}

  require Logger

  plug(OpenApiSpex.Plug.CastAndValidate)

  action_fallback(SageWeb.FallbackController)

  @spec open_api_operation(atom) :: Operation.t()
  def open_api_operation(action) do
    operation = String.to_existing_atom("#{action}_operation")
    apply(__MODULE__, operation, [])
  end

  @spec create_operation() :: Operation.t()
  def create_operation do
    %Operation{
      tags: ["carts"],
      summary: "Create cart",
      description: "Create a new cart with items",
      operationId: "CartsController.create",
      requestBody:
        Operation.request_body(
          "The cart with items",
          "application/json",
          Cart,
          required: true
        ),
      responses: %{
        201 =>
          Operation.response(
            "CreateCartSuccessResponse",
            "application/json",
            CreateCartSuccessResponse
          ),
        400 =>
          Operation.response(
            "CreateCartErrorResponse",
            "application/json",
            CreateCartErrorResponse
          )
      }
    }
  end

  @doc """
  POST /api/carts
  """
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn = %{body_params: body_params}, params) do
    Logger.debug("body_params => #{inspect(body_params)}")
    Logger.debug("params => #{inspect(params)}")
    items = Map.get(body_params, :items)
    Logger.debug("items => #{inspect(items)}")

    cart = %{id: Ecto.UUID.generate(), items: items}

    conn
    |> put_resp_header("location", "/api/carts/#{cart.id}")
    |> put_resp_content_type("application/json")
    |> send_resp(:created, Jason.encode!(%{data: cart}))
  end
end
