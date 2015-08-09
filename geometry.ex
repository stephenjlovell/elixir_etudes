defmodule Geom do
  @moduledoc """
  This is the first module I ever wrote in Elixir.
  """

  @doc """
    This function calculates the area of the specified shape.
  """
  def area(shape, a, b) do
    case shape do
      :rectangle  -> a * b
      :triangle   -> (a * b)/2.0
      :elipse     -> a * b * :math.pi()  # a and m are major and minor radii
    end
  end

end
