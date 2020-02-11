defmodule TsAccess.Getters do
  defmacro __before_compile__(env) do
    fields = Module.get_attribute(env.module, :fields, [])
    types = Module.get_attribute(env.module, :types, [])

    Enum.map(fields, fn {field, _default} ->
      type = Keyword.get(types, field)

      quote do
        @spec unquote(field)(%unquote(env.module){}) :: unquote(type)
        def unquote(field)(struct) do
          Map.get(struct, unquote(field))
        end

        defoverridable [{unquote(field), 1}]
      end
    end)
  end
end