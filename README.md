# TsAccess

Library to generate getters and setters for modules that are
using [TypedStruct](https://github.com/ejpcmac/typed_struct)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ts_access` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ts_access, "~> 0.1.0"}
  ]
end
```

## Example

Use `TsAccess` module as `@before_compile` and setters/getters will be generated
for module:

```elixir
defmodule Example do
  @before_compile TsAccess
  use TypedStruct

  typedstruct do
    field(:name, :string)
  end
end

iex> Example.name(%Example{}, "John Doe")
%Example{name: "John Doe"}

iex> Example.name(%Example{name: "John Doe"})
"John Doe"
```


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ts_access](https://hexdocs.pm/ts_access).

