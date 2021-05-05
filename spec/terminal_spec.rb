# frozen_string_literal: true

require './lib/terminal'
require './lib/stock'
require './lib/cash_register'

describe Terminal do
  subject { described_class.new }

  describe '#welcome_text' do
    let(:correct_output) { /Welcome to Vending Machine\nplease enter command/ }

    it 'should welcome' do
      expect do
        subject.welcome_text
      end.to output(correct_output).to_stdout
    end
  end

  describe '#help_text' do
    let(:correct_output) { /you are now in main menu\navailable commands are \["help", "order", "exit"\]/ }

    it 'should show help text' do
      expect do
        subject.help_text
      end.to output(correct_output).to_stdout
    end
  end

  describe '#display_help' do
    let(:correct_output) do
      /select product by typing it's name\ninsert coins one by one by enering it's value and pressing enter/
    end

    it 'should show detailed help' do
      expect do
        subject.display_help
      end.to output(correct_output).to_stdout
    end
  end

  describe '#return_change' do
    let(:correct_output) { /And here is your change:\n5\n0\.25/ }

    it 'should return change' do
      expect do
        subject.return_change(coins: [Coin.new(5, 1), Coin.new(0.25, 1)])
      end.to output(correct_output).to_stdout
    end
  end

  describe '#return_product' do
    let(:correct_output) { /Here is your delicious test only for 3\.5!/ }

    it 'should return change' do
      expect do
        subject.return_product(product: Product.new('test', 1, 3.5))
      end.to output(correct_output).to_stdout
    end
  end

  describe '#reject_inserted_coins' do
    context 'no coins' do
      let(:correct_output) { // }

      it 'should return nothing' do
        expect do
          subject.reject_inserted_coins(coins: [])
        end.to output(correct_output).to_stdout
      end
    end

    context 'with coins' do
      let(:correct_output) { /sorry, we can't process your request, here are your coins\n5/ }

      it 'should return inserted' do
        expect do
          subject.reject_inserted_coins(coins: [Coin.new(5, 1)])
        end.to output(correct_output).to_stdout
      end
    end
  end

  describe '#no_change_available' do
    let(:correct_output) { /sorry, vending machine does not have enough coins for change/ }

    it 'should show message' do
      expect do
        subject.no_change_available
      end.to output(correct_output).to_stdout
    end
  end

  describe '#need_more_coins' do
    let(:correct_output) { /insert coin\ntotal paid: 1\.0\nleft to pay: 2\.5/ }

    it 'should show total and price' do
      expect do
        subject.need_more_coins(total: 1.0, price: 3.5)
      end.to output(correct_output).to_stdout
    end
  end

  describe '#product_details' do
    let(:correct_output) { 'test1 -> 1.25' }

    it 'should show total and price' do
      expect(subject.product_details(product: Product.new('test1', 1, 1.25))).to eq(correct_output)
    end
  end

  describe '#display_products' do
    let(:correct_output) { /Available products are:\ntest1 -> 1\.25\ntest -> 3\.5/ }

    it 'should show available products' do
      expect do
        subject.display_products(products: [Product.new('test1', 1, 1.25), Product.new('test', 1, 3.5)])
      end.to output(correct_output).to_stdout
    end
  end
end
