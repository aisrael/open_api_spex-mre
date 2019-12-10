defmodule ApiWeb.CartsController do
  use ApiWeb, :controller

  require Logger

  @doc """
  POST /api/carts
  """
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn = %{body_params: body_params}, params) do
    Logger.debug("body_params => #{inspect(body_params)}")
    Logger.debug("params => #{inspect(params)}")
    items = Map.get(body_params, "items")
    Logger.debug("items => #{inspect(items)}")

    cart = %{id: Ecto.UUID.generate(), items: items}

    conn
    |> put_resp_header("location", cart.id)
    |> put_resp_content_type("application/json")
    |> send_resp(:created, Jason.encode!(%{data: cart}))
  end
end
