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

  @doc "Returns the mean (average) of a list of numbers"
  @spec mean([number]) :: number
  def mean(nums) do
    sum(nums) / Enum.count(nums)
  end

  @doc "Returns the sum of a list of numbers"
  @spec sum([number]) :: number
  def sum(nums), do: List.foldl(nums, 0, fn x, acc -> x + acc end )

  @doc "calculates the Population Standard Deviation of a list of numbers."
  @spec stdv_pop([number]) :: number
  def stdv_pop(nums) do
    variance_pop(nums) |> :math.sqrt()
  end

  @doc "calculates the (sample) Standard Deviation of a list of numbers."
  @spec stdv([number]) :: number
  def stdv(nums) do
    variance(nums) |> :math.sqrt()
  end

  @doc "calculates the Population Variance of a list of numbers."
  @spec variance([number]) :: number
  def variance(nums) do
    variance(nums, Enum.count(nums)-1)
  end

  @doc "calculates the (sample) Variance of a list of numbers."
  @spec variance_pop([number]) :: number
  def variance_pop(nums) do
    variance(nums, Enum.count(nums))
  end

  defp variance(nums, n) do
    mu = mean(nums)
    sum(for x <- nums do
      delta = x - mu
      delta * delta
    end) / n
  end


end
