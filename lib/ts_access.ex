defmodule TsAccess do
  @moduledoc """
  Module that when added as before compile module to
  module that is using typedstruct, will generate getters
  and setters for field's of defined struct. Generated
  functions will also have walid specs so dialyzer should
  report when setters/getters are used with wrong types

  ## EXAMPLES

  If we have struct

  ```
  defmodule Example do
    @before_compile TsAccess
    use TypeStruct

    typedstruct do
      field(:name, :string)
    end
  end
  ```
  Then it will generate:
  * Example.name/1 returning name
  * Example.name/2 that return struct with updated name
  """
  defmacro __before_compile__(env) do
    [
      TsAccess.Getters.generate_getters(env.module),
      TsAccess.Setters.generate_setters(env.module)
    ]
  end
end
