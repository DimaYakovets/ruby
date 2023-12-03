require_relative 'parser'
require_relative 'init'
require_relative 'cart'
require_relative 'item'

class MainApplication
  def run
    cart = Cart.new
    parser = Parser.new
    
    items = parser.parse_items

    items.each do |item|
      cart.add_item(item)
      
      item.info do |item|
        puts "Added to cart: '#{item.to_s}'"
      end
    end

    cart.save_to_json
    cart.save_to_csv
    cart.save_to_file
  end
end
