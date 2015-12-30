defmodule Dijkstra do
  @vsn 0.1

  @doc """
   gcd/3 recursively finds the greatest common denominator.
   Implemented using cond.
  """
  def gcd(x, y) do
    cond do
      x == y -> x
      x > y -> gcd(x-y, y)
      x < y -> gcd(x, y-x)
    end
  end

  @doc """
   gcd_guard/3 recursively finds the greatest common denominator.
   Implemented with a guard clause.
  """
  def gcd_guard(x, y) when x > y do
    gcd_guard(x-y, y)
  end

  def gcd_guard(x, y) when x < y do
    gcd_guard(x, y-x)
  end

  def gcd_guard(x, _) do # x == y
    x
  end

end
