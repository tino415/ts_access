defmodule TsAccess.Getters do
  @moduledoc """
  Generate setters for structure defined using `typedstruct`
  """

  defmacro __using__(_opts) do
    quote do
      @before_compile TsAccess.Getters
    end
  end

  defmacro __before_compile__(env) do
    TsAccess.Getters.typedstruct(env.module)
  end

  defmacro defgetter(field, type \\ nil) do
    quote do
      @spec unquote(field)(%__MODULE__{}) :: unquote(type)
      def unquote(field)(%__MODULE__{unquote(field) => value}), do: value
    end
  end

  def typedstruct(module) do
    fields = Module.get_attribute(module, :fields, [])
    types = Module.get_attribute(module, :types, [])

    generate_getters(module, fields, types)
  end

  def generate_getters(module, fields, types) do
    Enum.map(fields, fn {field, _default} ->
      type = Keyword.get(types, field)

      quote generated: true do
        @spec unquote(field)(%unquote(module){}) :: unquote(type)
        def unquote(field)(%unquote(module){unquote(field) => value}), do: value
      end
    end)
  end
end
