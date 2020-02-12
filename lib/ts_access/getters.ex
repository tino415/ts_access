defmodule TsAccess.Getters do
  @moduledoc """
  Generate setters for structure defined using `typedstruct`
  """
  defmacro __before_compile__(env) do
    TsAccess.Getters.generate_getters(env.module)
  end

  def generate_getters(module) do
    fields = Module.get_attribute(module, :fields, [])
    types = Module.get_attribute(module, :types, [])

    Enum.map(fields, fn {field, _default} ->
      type = Keyword.get(types, field)

      quote generated: true do
        @spec unquote(field)(%unquote(module){}) :: unquote(type)
        def unquote(field)(%unquote(module){} = struct) do
          Map.get(struct, unquote(field))
        end
      end
    end)
  end
end
