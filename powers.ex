defmodule Powers do
  # we're not gonna name a function 'raise()', that's just asking for confusion.
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

end
