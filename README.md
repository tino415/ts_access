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

Use `TsAccess` and setters/getters will be generated
for module (`use TsAccess` need to be after `use TypedStruct`):

```elixir
defmodule Example do
  use TypedStruct
  use TsAccess

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

## Change Log

* 0.6.0 - added lenses
* 0.5.0 - added explicit use mode
* 0.3.0 - added use interface
* 0.4.0 - improve generated functions, defgetter/defsetter macros

