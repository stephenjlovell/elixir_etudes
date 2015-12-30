defmodule Powers do
  @doc """
    pow(x, n) raises x to the power of n.
  """
  def pow(_, 0) do
    1
  end

  def pow(x, 1) do
    x
  end

  def pow(x, n) when n > 0 do
    pow(x, n, 1)
  end

  def pow(x, n) when n < 0 do
    1.0 / pow(x, -n)
  end

  defp pow(_, 0, acc) do
    acc
  end

  defp pow(x, n, acc) do
    pow(x, n-1, acc * x)
  end


  @doc """
    nth_root(x, n) returns the nth root of x using the Newton-Raphson method.
  """
  def nth_root(x, n) when is_integer(n) do
    nth_root(x, n, x / 2.0)
  end

  defp nth_root(x, n, a) do
    IO.puts("Current guess is #{a}")
    next = a - (f(x, n, a)/f_prime(n, a))
    if abs(a-next) < 1.0e-9 do
      next
    else
      nth_root(x, n, next)
    end
  end

  defp f(x, n, a) do
    pow(a, n) - x
  end

  defp f_prime(n, a) do
    n * pow(a, n-1)
  end

end
