# frozen_string_literal: true

Coin = Struct.new(:value, :quantity)

class CashRegister
  attr_accessor :coins

  COINS = [
    Coin.new(0.25, 1),
    Coin.new(0.5, 2),
    Coin.new(1, 0),
    Coin.new(3, 1),
    Coin.new(5, 1)
  ].freeze

  def initialize(coins: COINS)
    @coins = coins
  end

  def deposit_coins(coins:)
    coins.each do |c|
      find_coin(value: c.value).quantity += 1
    end
  end

  def withdraw_coins(coins:)
    coins.each do |c|
      find_coin(value: c.value).quantity -= 1
    end
  end

  # def restock(value:)
  #   find_coin(value: value).quantity += 1
  # end

  def available_coins
    coins.select { |coin| coin.quantity.positive? }
  end

  def find_coin(value:)
    coins.select { |coin| coin.value == value }[0]
  end

  def available_to_return_change?(change:)
    return true if change_to_coins(change: change).sum(&:value) == change

    false
  end

  def change_to_coins(change: change)
    available_coins.reverse(&:value)
                   .map do |coin|
      f = change / coin.value
      change %= coin.value # change to divmod?
      Array.new(f) { Coin.new(coin.value, 1) }
    end.flatten
  end
end
