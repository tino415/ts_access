defmodule TsAccess do
  @moduledoc """
  Module that will generate getters
  and setters for field's of defined struct. Generated
  functions will also have walid specs so dialyzer should
  report when setters/getters are used with wrong types

  ## EXAMPLES

  If we have struct

  ```
  defmodule Example do
    use TypeStruct
    use TsAccess

    typedstruct do
      field(:name, :string)
    end
  end
  ```
  Then it will generate:
  * Example.name/1 returning name
  * Example.name/2 that return struct with updated name
  """

  defmacro __using__(_opts) do
    quote do
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(env) do
    [
      TsAccess.Getters.typedstruct(env.module),
      TsAccess.Setters.typedstruct(env.module)
    ]
  end
end
