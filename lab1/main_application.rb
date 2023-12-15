require_relative 'parser'
require_relative 'cart'
require_relative 'item'

class MainApplication
  def run
    web_address = "https://www.yakaboo.ua/ua/knigi/hudozhestvennaja-literatura.html"
    data_path = "#{__dir__}/data"
    condition = ->(item) { item.price < 1000 }
    
    cart = Cart.new
    parser = Parser.new
    
    items = parser.parse_items(web_address, condition)

    items.each do |item|
      cart.add_item(item)
      
      item.info do |item|
        puts "Added to cart: '#{item.to_s}'"
      end
    end

    cart.save_to_json data_path
    cart.save_to_csv data_path
    cart.save_to_file data_path
  end
end
