defmodule TsAccess.Getters do
  @moduledoc """
  Generate setters for structure
  """
  import TsAccess.Support, only: [fields: 1, types: 1]

  defmacro __using__(explicit: true) do
    quote do
      require TsAccess.Getters
      import TsAccess.Getters, only: [defgetter: 1, defgetter: 2]
    end
  end

  defmacro __using__(_opts) do
    quote do
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(%Macro.Env{module: module}) do
    __defgetters__(module)
  end

  defmacro defgetter(field, type \\ nil) do
    __defgetter__(field, type)
  end

  def __defgetters__(module) when is_atom(module) do
    __defgetters__(fields(module), types(module))
  end

  def __defgetters__(fields, types) do
    Enum.map(fields, fn {field, _default} ->
      type = Keyword.get(types, field)
      __defgetter__(field, type)
    end)
  end

  def __defgetter__(field, type) do
    quote generated: true do
      @spec unquote(field)(%__MODULE__{}) :: unquote(type)
      def unquote(field)(%__MODULE__{unquote(field) => value}), do: value
    end
  end
end
