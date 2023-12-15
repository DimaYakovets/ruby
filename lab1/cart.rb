require_relative "item_container"
require "json"
require "csv"

class Cart 
  include ItemContainer 

  def initialize
    @items = []
  end

  def save_to_file(data_path)
    File.open("#{data_path}/items.txt", "w") do |file|
      file.puts "Items:"
      
      @items.each do |item|
        file.puts item.to_s 
      end
    end
  end

  def save_to_json(data_path)
    File.open("#{data_path}/items.json", "w") do |file|
      file.puts JSON.pretty_generate(to_h)
    end
  end

  def save_to_csv(data_path)
    CSV.open("#{data_path}/items.csv", "w") do |csv|
      csv << ["title", "author", "categories", "price", "image_url"] 
      @items.each do |item|
        csv << item.to_h.values
      end
    end
  end
end
