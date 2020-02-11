defmodule TsAccess.Setters do
  defmacro __before_compile__(env) do
    fields = Module.get_attribute(env.module, :fields, [])
    types = Module.get_attribute(env.module, :types, [])

    Enum.map(fields, fn {field, _default} ->
      type = Keyword.get(types, field)

      quote do
        @spec unquote(field)(%unquote(env.module){}, unquote(type)) :: %unquote(env.module){}
        def unquote(field)(struct, value) do
          Map.put(struct, unquote(field), value)
        end

        defoverridable [{unquote(field), 2}]
      end
    end)
  end
end