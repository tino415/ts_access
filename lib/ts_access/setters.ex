defmodule TsAccess.Setters do
  @moduledoc """
  Generate setters for structure
  """
  import TsAccess.Support, only: [fields: 1, types: 1]

  defmacro __using__(explicit: true) do
    quote do
      require TsAccess.Setters
      import TsAccess.Setters, only: [defsetter: 1, defsetter: 2]
    end
  end

  defmacro __using__(_opts) do
    quote do
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(%Macro.Env{module: module}) do
    __defsetters__(module)
  end

  defmacro defsetter(field, type \\ nil) do
    __defsetter__(field, type)
  end

  def __defsetters__(module) when is_atom(module) do
    __defsetters__(fields(module), types(module))
  end

  def __defsetters__(fields, types) do
    Enum.map(fields, fn {field, _default} ->
      type = Keyword.get(types, field)
      __defsetter__(field, type)
    end)
  end

  def __defsetter__(field, type) do
    quote generated: true do
      @doc """
      Setter for #{unquote(field)}
      """
      @spec unquote(field)(%__MODULE__{}, unquote(type)) :: %__MODULE__{}
      def unquote(field)(%__MODULE__{} = struct, value) do
        %__MODULE__{struct | unquote(field) => value}
      end
    end
  end
end
