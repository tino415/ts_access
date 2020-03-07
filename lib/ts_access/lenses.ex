defmodule TsAccess.Lenses do
  @moduledoc """
  Generate field_lens functions that can be used 
  with elixir Access behaviour 

  ## EXAMPLES

  ```
  defmodule Example do
    use TsAccess.Lenses

    defstruct [
      :name
    ]
  end

  iex> get_in(Example{name: "Testovic"}, [Example.name_lens])
  "Testovic"
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
    Enum.map(fields, fn {field, _default} ->
      __deflens__(field)
    end)
  end

  def __deflens__(field) do
    quote generated: true do
      def unquote(:"#{field}_lens")() do
        Access.key(unquote(field))
      end
    end
  end
end
