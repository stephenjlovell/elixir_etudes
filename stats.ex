defmodule Stats do

  @doc "Returns the minimum value in a list of numbers"
  @spec minimum([number]) :: number
  def minimum(nums) do
    minimum(hd(nums), tl(nums))
  end

  defp minimum(best, [h|t]) do
    minimum(min(best,h), t)
  end

  defp minimum(best, []), do: best

  @doc "Returns the maximum value in a list of numbers"
  @spec maximum([number]) :: number
  def maximum(nums) do
    maximum(hd(nums), tl(nums))
  end

  defp maximum(best, [h|t]) do
    maximum(max(best,h), t)
  end

  defp maximum(best, []), do: best

  @doc "Returns a list containing the minimum and maximum in a list of numbers"
  @spec range([number]) :: [number]
  def range(nums) do
    [ minimum(nums), maximum(nums) ]
  end

end
