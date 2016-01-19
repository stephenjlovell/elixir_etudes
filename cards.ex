defmodule Cards do

  @doc "returns a list of 52 tuples representing a playing card deck."
  @spec make_deck() :: [tuple]
  def make_deck do
    for suit <- ~w(Diamonds Clubs Hearts Spades),
        value <- Enum.to_list(2..10) ++ ~w(J Q K A) do
        { value, suit}
    end
  end


end
