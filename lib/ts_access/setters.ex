defmodule TsAccess.Setters do
  @moduledoc """
  Generate set functions for module that is using `typedstruct`.
  """
  defmacro __before_compile__(env) do
    TsAccess.Setters.generate_setters(env.module)
  end

  def generate_setters(module) do
    fields = Module.get_attribute(module, :fields, [])
    types = Module.get_attribute(module, :types, [])

    Enum.map(fields, fn {field, _default} ->
      type = Keyword.get(types, field)

      quote generated: true do
        @spec unquote(field)(%unquote(module){}, unquote(type)) :: %unquote(module){}
        def unquote(field)(struct, value) do
          Map.put(struct, unquote(field), value)
        end

        defoverridable [{unquote(field), 2}]
      end
    end)
  end
end
