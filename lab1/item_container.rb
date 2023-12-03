module ItemContainer
  def self.included(instance)
    instance.extend ClassMethods
    instance.include InstanceMethods
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
    
    def method_missing(method, *arguments, &block) 
      if method.start_with?('show_all_items_by_') 
        attribute = method[18..-1] 
        show_all_items_by(attribute) 
      else 
        super 
      end 
    end

    def respond_to_missing?(method_name, include_private = false) 
      method_name.start_with?('show_all_items_by_') || super 
    end 
    
    private 
    
    def show_all_items_by(attribute)
      if @items.first.respond_to?(attribute)
        sorted_items = @items.sort_by(&attribute.method(:call))
        sorted_items.each { |item| puts item }
      else
        puts "Attribute '#{attribute}' is missing in class 'Item'."
      end
    end
  end
end