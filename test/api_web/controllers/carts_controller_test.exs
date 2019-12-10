defmodule ApiWeb.CartsControllerTest do
  use ApiWeb.ConnCase

  require Logger

  setup %{conn: conn} do
    {:ok,
     conn:
       conn
       |> put_req_header("accept", "application/json")
       |> put_req_header("content-type", "application/json")}
  end

  describe "create cart" do
    test "accepts a cart with items", %{conn: conn} do
      conn =
        conn
        |> post(Routes.carts_path(conn, :create),
          items: [42, 1337]
        )

      assert %{"data" => %{"items" => items}} = json_response(conn, 201)
      assert [42, 1337] == items
    end

    test "doesn't accept an empty cart", %{conn: conn} do
      conn =
        conn
        |> post(Routes.carts_path(conn, :create),
          items: []
        )

      assert %{"errors" => errors} = json_response(conn, 400)
    end
  end
end
