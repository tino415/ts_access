defmodule Support.Example do
  @moduledoc """
  Example module for tests
  """
  use TypedStruct

  @before_compile TsAccess

  typedstruct do
    field(:name, :string)
    field(:age, :integer)
  end
end
