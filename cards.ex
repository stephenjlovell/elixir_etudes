defmodule Cards do

  @doc "returns a list of 52 tuples representing a playing card deck."
  @spec make_deck() :: [tuple]
  def make_deck do
    for suit <- ~w(Diamonds Clubs Hearts Spades),
        value <- Enum.to_list(2..10) ++ ~w(J Q K A) do
        { value, suit}
    end
  end

  @doc "shuffles the deck of cards into a random order."
  @spec shuffle([tuple]) :: [tuple]
  def shuffle(list) do
    :random.seed(:erlang.now())
    shuffle(list, [])
  end

  # returns the shuffled cards.
  defp shuffle([], shuffled) do
    shuffled
  end

  @doc """
    shuffle/2 takes two lists representing shuffled and unshuffled cards.  It recursively draws a card at random from the unshuffled
    cards and adds it to the shuffled cards, until no unshuffled cards remain.  This is known as the Knuth Shuffle.
  """
  defp shuffle(unshuffled, shuffled) do
    {leading, [h | t]} = Enum.split(unshuffled, :random.uniform(Enum.count(unshuffled)) - 1)
    shuffle(leading ++ t, [h | shuffled])
  end

end
