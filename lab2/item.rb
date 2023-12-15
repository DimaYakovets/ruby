module Yakovets_Tsyhanash
  class Item
    include Comparable

    def initialize(attrs = {})
      attrs.each do |key, value|
        self.instance_variable_set "@#{key}", value
        self.class.send(:attr_accessor, key)
      end
    end

    def info(&block)
      yield self if block_given?
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
      title <=> other.title
    end
  end
end