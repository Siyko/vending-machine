# frozen_string_literal: true

require_relative 'terminal'
require_relative 'stock'
require_relative 'cash_register'

class VendingMachine
  attr_accessor :stock, :balance, :terminal, :selected_product, :change_needed, :cash_register

  def initialize
    @stock = Stock.new
    @cash_register = CashRegister.new
    @inserted_coins = []
    @selected_product = nil
    @terminal = Terminal.new
    @change_needed = nil
  end

  def start
    terminal.welcome_text

    loop do
      reset_machine

      terminal.help_text
      input = terminal.get_input

      case input
      when /\Ahelp\z/i
        terminal.display_help
      when /\Aorder\z/i
        process_order
      when /\Aexit\z/i
        exit
      else puts 'Invalid command'
      end
    end
  end

  private

  def reset_machine
    @inserted_coins = []
    @selected_product = nil
    @change_needed = nil
    terminal.reject_inserted_coins(coins: @inserted_coins) unless @inserted_coins.empty?
  end

  def process_order
    terminal.display_products(products: stock.available_products)

    unless self.selected_product = stock.find_product(name: terminal.get_input)
      terminal.reject_input

      return
    end

    user_payment

    cash_register.deposit_coins(coins: @inserted_coins)
    unless cash_register.available_to_return_change?(change: change_needed)
      terminal.no_change_available
      cash_register.withdraw_coins(coins: @inserted_coins)
      terminal.reject_inserted_coins(coins: @inserted_coins)
      return
    end

    stock.sell_product(name: selected_product.name)
    change_coins = cash_register.change_to_coins(change: change_needed)
    cash_register.withdraw_coins(coins: change_coins)
    terminal.return_product(product: selected_product)
    terminal.return_change(coins: change_coins)
  end

  def inject_coin(value:)
    return terminal.reject_input unless cash_register.coins.map(&:value).include? value.to_f

    @inserted_coins << Coin.new(value.to_f, 1)
  end

  def total
    @inserted_coins.sum(&:value)
  end

  def user_payment
    terminal.ask_for_coins
    inject_coin(value: terminal.get_input)
    product_price = @selected_product.price

    while total < product_price
      terminal.need_more_coins(total: total, price: product_price)
      inject_coin(value: terminal.get_input)
    end

    self.change_needed = total - product_price
  end
end
