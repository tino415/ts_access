defmodule TsAccess.Support do
  @moduledoc false

  def fields(module) do
    module
    |> Module.get_attribute(:struct, [])
    |> Map.from_struct()
  end

  def types(module) do
    Module.get_attribute(module, :types, [])
  end
end
