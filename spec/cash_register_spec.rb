# frozen_string_literal: true

require './lib/cash_register'

COINS = [
  Coin.new(0.25, 3),
  Coin.new(0.5, 1),
  Coin.new(1, 0),
  Coin.new(3, 2),
  Coin.new(5, 1)
].freeze

describe CashRegister do
  subject { described_class.new(coins: COINS) }

  describe '#initialize' do
    it 'should init correctly' do
      expect(subject.coins.count).to eq 5
    end
  end

  describe '#deposit_coins' do
    let!(:coins_to_deposit) { [Coin.new(1, 1), Coin.new(0.25, 1), Coin.new(1, 1)] }

    it 'changes amount of coins' do
      subject.deposit_coins(coins: coins_to_deposit)
      expect(subject.coins.count).to eq 5
      expect(subject.find_coin(value: 1).quantity).to eq 2
      expect(subject.find_coin(value: 0.25).quantity).to eq 4
    end
  end

  describe '#withdraw_coins' do
    let!(:coins_to_withdraw) { [Coin.new(5, 1), Coin.new(3, 1), Coin.new(0.25, 1)] }

    it 'changes amount of coins' do
      subject.withdraw_coins(coins: coins_to_withdraw)
      expect(subject.coins.count).to eq 5
      expect(subject.find_coin(value: 5).quantity).to eq 0
      expect(subject.find_coin(value: 3).quantity).to eq 1
      expect(subject.find_coin(value: 0.25).quantity).to eq 3
    end
  end

  describe '#find_coin' do
    it 'finds a coin' do
      expect(subject.find_coin(value: 0.25)).to eq(subject.coins[0])
    end
  end

  describe '#available_coins' do
    it 'shows correct array' do
      subject { described_class.new(coins: COINS) }
      expect(subject.available_coins).to eq([COINS[0], COINS[1], COINS[2], COINS[3]])
    end
  end
end
