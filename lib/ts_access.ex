defmodule TsAccess do
  @moduledoc """
  Module that will generate getters
  and setters for field's of defined struct. Generated
  functions will also have walid specs so dialyzer should
  report when setters/getters are used with wrong types.

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

  This also works for modules that are not using typedstruct's.
  In that case types of fields needs to by set in module attribute `types`.

  ```
  defmodule Example do
    use TsAccess

    @types [
      name: String.t()
    ]

    defstruct [
      :name,
      :untyped
    ]
  end
  ```
  In this case `Example.name/1`, `Example.name/2`, `Example.untyped/1` and `Example.untyped/2`
  will be generated but `Example.untyped` will not have `@spec`
  ### Explicit mode

  Library also can by used in explicit mode when getters, setters or accessors
  are not automaticali generated, but must be explicitli defined using macros

  For instance:

  ```
  defmodule Example do
    use TsAccess, explicit: true

    defstruct [
      :accessible,
      :readable,
      :writable
    ]

    defaccesor :accessible

    defgetter :readable

    defsetter :writable
  end
  """

  defmacro __using__(explicit: true) do
    quote do
      require TsAccess
      require TsAccess.Getters
      require TsAccess.Setters

      import TsAccess, only: [defaccessor: 1, defaccessor: 2]
      import TsAccess.Getters, only: [defgetter: 1, defgetter: 2]
      import TsAccess.Setters, only: [defsetter: 1, defsetter: 2]
    end
  end

  defmacro __using__(_opts) do
    quote do
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(%Macro.Env{module: module}) do
    [
      TsAccess.Getters.__defgetters__(module),
      TsAccess.Setters.__defsetters__(module)
    ]
  end

  @doc """
  Define accessor for struct field in explicit mode

  ## EXAMPLES

  ```
  defmodule Example do
    use TsAccess, explicit: true

    defstruct [
      :name
    ]

    defaccessor :name
  end
  ```

  This will generate Example.name/1 to get name and Example.name/2 to set name

  We also can set accessor field type

  ```
  defmodule Example do
    use TsAccess, explicit: true

    defstruct [
      :name
    ]

    defaccessor :name, String.t()
  end
  ```
  """
  defmacro defaccessor(field, type \\ nil) do
    [
      TsAccess.Getters.__defgetter__(field, type),
      TsAccess.Setters.__defsetter__(field, type)
    ]
  end
end
