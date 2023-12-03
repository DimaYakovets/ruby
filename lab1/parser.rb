require 'nokogiri'
require 'faraday'
require_relative 'item'
require_relative 'config'

class Parser
  def parse_items()
    items = []

    doc = Nokogiri::HTML(Faraday.get(Config.web_address).body)
    books = doc.css('.category-card.category-layout')

    books.each_with_index do |book, index|
      break if index == 10
      book_url = "https://www.yakaboo.ua" + book.css('.category-card__name').attr('href').text.strip
      item = parse_item(book_url)

      next unless Config.condition.call(item)
      
      items << item
    end

    items
  end

  def parse_item(book_url)
    book_doc = Nokogiri::HTML(Faraday.get(book_url).body)

    title = book_doc.css('.base-product__title').first.text.strip
    author = book_doc.css('.base-product__author').first.text.strip
    image_url = book_doc.css('.slide__item > img').attr('src').text.strip
    categories = book_doc.at('span:contains("Категорія")').parent.css('.option-button').map { |element| element.text.strip }
    price = book_doc.css('.ui-price-display__main').first.text.strip.match(/\d+/)[0].to_i

    Item.new(title, author, categories, price, image_url)
  end
end
