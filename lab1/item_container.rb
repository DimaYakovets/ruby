module ItemContainer
  def self.included(instance)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  include Enumerable

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
    
    def method_missing(method)

    end
  end
end