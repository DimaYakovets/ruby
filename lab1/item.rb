class Item
  attr_accessor :title, :author, :categories, :price, :image_url

  def initialize(title, author, categories, price, image_url)
    @title = title
    @author = author
    @categories = categories
    @price = price
    @image_url = image_url
  end

  def info(&block)
    yield self if block_given?
  end

  def to_s
    "#{@title} by #{@author}: #{@price}"
  end

  def to_h
  {
    title: @title,
    author: @author,
    categories: @categories,
    price: @price,
    image_url: @image_url
  }
  end
end
