defmodule Geom do
  @moduledoc """
  This is the first module I ever wrote in Elixir.
  """

  @doc """
    This function calculates the area of the specified shape.
  """
  @spec area(atom(), number(), number()) :: number()
  def area(shape, dim1, dim2) when dim1 > 0 and dim2 > 0 do
    case shape do
      :rectangle  -> dim1 * dim2
      :triangle   -> (dim1 * dim2) / 2
      :elipse     -> :math.pi() * dim1 * dim2
    end
  end

end
