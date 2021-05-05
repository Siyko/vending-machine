# frozen_string_literal: true

Product = Struct.new(:name, :quantity, :price)

class Stock
  attr_accessor :stock

  PRODUCTS = [
    Product.new('a', 1, 5),
    Product.new('b', 2, 3.25),
    Product.new('c', 3, 7.5),
    Product.new('d', 4, 2.5),
    Product.new('e', 5, 1.25)
  ].freeze

  def initialize(products: PRODUCTS)
    @stock = products
  end

  # def restock(name:)
  #   find_product(name: name).quantity += 1
  # end

  def sell_product(name:)
    find_product(name: name).quantity -= 1
  end

  def available_products
    stock.select { |product| product.quantity.positive? }
  end

  def find_product(name:)
    stock.select { |product| product.name == name }[0]
  end
end
