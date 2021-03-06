defmodule Player do

  @vsn 1.0

  def start(hand, dealer) do
    spawn(__MODULE__, :play, [hand, dealer])
  end

  def play(hand, dealer) do
    receive do
      :ready_up ->
        case hand do
          [] ->
            send(dealer, {:forfeit, self()})
          _ ->
            send(dealer, {:ok, Enum.count(hand), self()})
        end
        play(hand, dealer)
      {:take_cards, cards} ->
        play(hand ++ cards, dealer)
      {:give_cards, num_cards} ->
        case hand do
          [] ->
            send(dealer, {:forfeit, self()})
            play([], dealer)
          _  ->
            {cards_to_play, new_hand} = Enum.split(hand, num_cards)
            send(dealer, {:take_cards, cards_to_play, self()})
            play(new_hand, dealer)
        end
    end
  end


end
