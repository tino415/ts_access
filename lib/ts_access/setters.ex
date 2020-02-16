defmodule TsAccess.Setters do
  @moduledoc """
  Generate set functions for module that is using `typedstruct`.
  """

  defmacro __using__(_opts) do
    quote do
      @before_compile TsAccess.Setters
    end
  end

  defmacro __before_compile__(env) do
    TsAccess.Setters.typedstruct(env.module)
  end

  defmacro defsetter(field, type \\ nil) do
    quote generated: true do
      @spec unquote(field)(%__MODULE__{}, unquote(type)) :: %__MODULE__{}
      def unquote(field)(%__MODULE__{} = struct, value) do
        %__MODULE__{struct | unquote(field) => value}
      end
    end
  end

  def generate_setter(module, field, type \\ nil) do
    quote generated: true do
      @spec unquote(field)(%unquote(module){}, unquote(type)) :: %unquote(module){}
      def unquote(field)(%unquote(module){} = struct, value) do
        %unquote(module){struct | unquote(field) => value}
      end
    end
  end

  def typedstruct(module) do
    fields = Module.get_attribute(module, :fields, [])
    types = Module.get_attribute(module, :types, [])
    generate_setters(module, fields, types)
  end

  def generate_setters(module, fields, types) do
    Enum.map(fields, fn {field, _default} ->
      type = Keyword.get(types, field)

      quote generated: true do
        @spec unquote(field)(%unquote(module){}, unquote(type)) :: %unquote(module){}
        def unquote(field)(%unquote(module){} = struct, value) do
          %unquote(module){struct | unquote(field) => value}
        end
      end
    end)
  end
end
