module Yakovets_Tsyhanash
  class Item
    include Comparable

    def initialize(attrs = {})
      attrs.each do |key, value|
        self.instance_variable_set "@#{key}", value
        self.class.send(:attr_accessor, key)
      end
    end

    def to_s
      attributes = instance_variables.map do |var|
        "#{var.to_s[1..-1]}: #{instance_variable_get(var)}"
      end

      attributes.join("\n")
    end

    def to_h
      hash = {}

      instance_variables.each do |var|
        hash[var.to_s[1..-1]] = instance_variable_get(var)
      end

      hash
    end

    def <=>(other)
      if self.respond_to?(:title) && other.respond_to?(:title)
        self.title <=> other.title
      else
        0
      end
    end
  end
end