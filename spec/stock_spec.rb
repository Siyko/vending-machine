# frozen_string_literal: true

require './lib/stock'

PRODUCTS = [
  Product.new('test', 1, 10),
  Product.new('test1', 2, 3.25),
  Product.new('test2', 0, 1.5)
].freeze

describe Stock do
  subject { described_class.new(products: PRODUCTS) }

  describe '#initialize' do
    it 'should init correctly' do
      expect(subject.stock.count).to eq 3
    end
  end

  describe '#sell_product' do
    it 'decreses amount of product' do
      subject.sell_product(name: 'test')
      expect(subject.find_product(name: 'test').quantity).to eq(0)
    end
  end

  describe '#available_products' do
    it 'shows correct array' do
      expect(subject.available_products).to eq([PRODUCTS[1]]) # because we sold product in test above
    end
  end

  describe '#find_product' do
    it 'finds a product' do
      expect(subject.find_product(name: 'test1')).to eq(Product.new('test1', 2, 3.25))
    end
  end
end
