module Yakovets_Tsyhanash
  module ItemContainer
    def self.included(instance)
      instance.extend ClassMethods
      instance.include InstanceMethods
    end

    include Enumerable

    def each 
      return unless block_given?

      @items.each do |item|
          yield item
      end  
    end

    module ClassMethods 
    
    end 
    
    module InstanceMethods
      def add_item(item)
        @items << item
      end 
      
      def remove_item(item)
        @items.delete(item)
      end 
      
      def delete_items
        @items = []
      end

      def to_h
        {
          items: @items.map(&:to_h), 
        }
      end

      def to_s
        @items.each do |item|
          puts item.to_s
        end
      end
      
      def method_missing(method, *arguments, &block) 
        if method.to_s.start_with?('sort_by_') 
          attribute = method.to_s[8..-1] 
          sort_by(attribute) 
        else 
          super 
        end 
      end

      def respond_to_missing?(method_name, include_private = false) 
        method_name.start_with?('sort_by_') || super 
      end 
      
      private 
      
      def sort_by(attribute)
        if @items.first.respond_to?(attribute)
          sorted_items = @items.sort_by do |item| 
            item.send(attribute)
          end 
          
          sorted_items
        else
          puts "Attribute '#{attribute}' is missing in class 'Item'."
        end
      end
    end
  end
end
