defmodule ApiWeb.Schemas do
  @moduledoc """
  API Schema
  """

  alias OpenApiSpex.Schema

  defmodule Cart do
    @moduledoc """
    Cart Schema
    """
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Cart",
      description: "A shopping cart",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "UUID", format: :uuid},
        items: %Schema{
          description: "List of item ids",
          type: :array,
          items: %Schema{
            type: :integer
          },
          minItems: 1
        }
      },
      required: [:items],
      example: %{
        id: "f862a2df-d36d-4db6-9bdc-1403c1437f95",
        items: [42, 1337]
      }
    })
  end

  defmodule CreateCartSuccessResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateCartSuccessResponse",
      description: "A created cart",
      type: :object,
      properties: %{
        data: Cart
      },
      example: %{
        data: %{
          id: "f862a2df-d36d-4db6-9bdc-1403c1437f95",
          items: [42, 1337]
        }
      }
    })
  end

  defmodule CreateCartErrorResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateCartErrorResponse",
      description: "A list of errors",
      type: :object,
      properties: %{
        errors: %Schema{
          type: :array,
          items: %Schema{
            type: :object
          }
        }
      },
      example: %{
        errors: [
          %{
            "title" => "Invalid value",
            "detail" => "Invalid value for array",
            "source" => %{
              "pointer" => "/data/items"
            }
          }
        ]
      }
    })
  end
end
