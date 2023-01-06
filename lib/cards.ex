defmodule Cards do
  def create_deck do
    cards = [
      "Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"
    ]
    suits = [
      "Spades", "Clubs", "Hearts", "Diamonds"
    ]

    for suit <- suits, card <- cards do
        "#{card} of #{suit}"
    end

  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  def create_hand(hand_size) do

    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end
end