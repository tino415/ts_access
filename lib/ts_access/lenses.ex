defmodule TsAccess.Lenses do
  @moduledoc """
  Generate field functions that can be used 
  with elixir `Access` behaviour. 

  ## EXAMPLES

  ```
  defmodule Example do
    use TsAccess.Lenses

    defstruct [
      :name,
      online?: true
    ]
  end

  iex> get_in(%Example{name: "Testovic"}, [Example.name])
  "Testovic"

  iex> get_in(%Example{}, [Example.online?])
  true
  ```
  """
  import TsAccess.Support, only: [fields: 1]

  defmacro __using__(_opts) do
    quote do
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(%Macro.Env{module: module}) do
    __deflenses__(module)
  end

  def __deflenses__(module) when is_atom(module) do
    __deflenses__(fields(module))
  end

  def __deflenses__(fields) do
    Enum.map(fields, fn {field, default} ->
      __deflens__(field, default)
    end)
  end

  def __deflens__(field, default \\ nil) do
    quote generated: true do
      @doc """
      Lens for #{unquote(field)}, see `Access`
      """
      @spec unquote(field)() :: Access.access_fun(struct(), term())
      def unquote(field)() do
        Access.key(unquote(field), unquote(default))
      end
    end
  end
end
