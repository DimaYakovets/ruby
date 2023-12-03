require_relative "item_container"
require_relative "config"
require "json"
require "csv"

class Cart 
  include ItemContainer 
  include Enumerable

  def initialize
    @items = []
  end

  def save_to_file()
    File.open("#{Config.path}/items.txt", "w") do |file|
      file.puts "Items:"
      
      @items.each do |item|
        file.puts item.to_s 
      end
    end
  end

  def save_to_json()
    File.open("#{Config.path}/items.json", "w") do |file|
      file.puts JSON.pretty_generate(to_h)
    end
  end

  def save_to_csv()
    CSV.open("#{Config.path}/items.csv", "w") do |csv|
      csv << ["title", "author", "categories", "price", "image_url"] 
      @items.each do |item|
        csv << item.to_h.values
      end
    end
  end
end
