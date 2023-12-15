require_relative 'parser'
require_relative 'init'
require_relative 'cart'
require_relative 'item'
require_relative 'email_sender'

module Yakovets_Tsyhanash
  class MainApplication
    def run(index)
      cart = Cart.new
      parser = Parser.new
      
      items = parser.parse_items index

      puts "Task #{index} items:"

      items.each do |item|
        cart.add_item(item)
        
        item.info do |item|
          puts "Added to cart: #{item.title} by #{item.author}: #{item.price}"
        end
      end

      Config.file_ext.each do |ext|
        case ext
        when ".txt"
          cart.save_to_file index
        when ".csv"
          cart.save_to_csv index
        when ".json"
          cart.save_to_json index
        when ".yaml"
          cart.save_to_yaml index
        else
          puts "Unknown format"
        end
      end

      puts "Archive '#{index}_data.zip' is being created"

      Yakovets_Tsyhanash::Zipper.create_archive index
    
      puts "Archive '#{index}_data.zip' has been created"
    end
  end
end
