require_relative "item_container"
require_relative "config"
require "json"
require "csv"
require "yaml"

module Yakovets_Tsyhanash
  class Cart 
    include ItemContainer 
    include Enumerable
    
    def initialize
      @items = []
    end
    
    def save_to_file(prefix)
      File.open("#{Config.path}/#{prefix}_items.txt", "w") do |file|
      file.puts "Items:"
      
        @items.each do |item|
          file.puts item.to_s 
        end
      end
    end
  
    def save_to_json(prefix)
      File.open("#{Config.path}/#{prefix}_items.json", "w") do |file|
        file.puts JSON.pretty_generate(to_h)
      end
    end

    def save_to_csv(prefix)
      CSV.open("#{Config.path}/#{prefix}_items.csv", "w") do |csv|
        csv << ["title", "author", "categories", "price", "image_url"] 
        @items.each do |item|
          csv << item.to_h.values
        end
      end
    end

    def save_to_yaml(prefix)
      File.open("#{Config.path}/#{prefix}_data.yaml", "w") do |file|
        file.puts YAML.dump(to_h)
      end 
    end
  end
end
