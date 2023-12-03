require_relative 'zipper'
require_relative 'parser'
require_relative 'init'
require_relative 'cart'
require_relative 'item'

module Yakovets_Tsyhanash
  class Engine
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

      Config.file_ext.each do |ext|
        case ext
        when ".txt"
          cart.save_to_file()
        when ".csv"
          cart.save_to_csv()
        when ".json"
          cart.save_to_json()
        when ".yaml"
          cart.save_to_yaml()
        else
          puts "Invalid format"
        end
      end

      Yakovets_Tsyhanash::Zipper.create_archive()
    end
  end
end