# frozen_string_literal: true

class Terminal
  AVAILABLE_COMMANDS = %w[help order exit].freeze

  def welcome_text
    puts 'Welcome to Vending Machine'
    puts 'please enter command'
  end

  def display_products(products:)
    puts 'Available products are:'
    products.each do |p|
      puts product_details(product: p)
    end
    puts 'select a product'
  end

  def product_details(product:)
    "#{product.name} -> #{product.price}"
  end

  def get_input
    gets.chomp
  end

  def ask_for_coins
    puts 'insert coin'
  end

  def need_more_coins(total:, price:)
    puts 'insert coin'
    puts "total paid: #{total}"
    puts "left to pay: #{price - total}"
  end

  def reject_input
    puts 'invalid input'
  end

  def no_change_available
    puts 'sorry, vending machine does not have enough coins for change'
  end

  def reject_inserted_coins(coins:)
    return unless coins

    puts "sorry, we can't process your request, here are your coins"
    coins.each do |c|
      puts c.value
    end
  end

  def return_product(product:)
    puts "Here is your delicious #{product.name} only for #{product.price}!"
  end

  def return_change(coins:)
    puts 'And here is your change:'
    coins.each do |c|
      puts c.value
    end
  end

  def help_text
    puts 'you are now in main menu'
    puts "available commands are #{AVAILABLE_COMMANDS}"
  end

  def display_help
    puts 'select product by typing it\'s name'
    puts 'insert coins one by one by enering it\'s value and pressing enter'
  end
end
