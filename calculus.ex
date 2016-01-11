defmodule Calculus do

  @doc "Approximates the derivative of function f(x) at x."
  @spec derivative(fun, number) :: number
  def derivative(f, x) do
    delta = 1.0e-10
    (f.(x + delta) - f.(x)) / delta
  end


end
