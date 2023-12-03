class Item
  attr_accessor :title, :author, :category, :publisher, :year, :language, :about

  def initialize(title, author, category, publisher, year, language)
    @title = title
    @author = author
    @category = category 
    @publisher = publisher
    @year = year
    @language = language
  end

  def info(&block)
    yield self if block_given?
  end

  def to_s
    "#{@title} (#{@year}) by #{@author} publisher: #{@publisher}"
  end
    
  def to_h
  {
    title: @title,
    author: @author,
    category: @category,
    publisher: @publisher,
    year: @year,
    language: @language,
  }
  end

  def <=>(other)
    title <=> other.title
  end
end 
