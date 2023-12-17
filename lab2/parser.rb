require 'nokogiri'
require 'faraday'
require 'mechanize'
require_relative 'item'
require_relative 'config'

module Yakovets_Tsyhanash
  class Parser
    def parse_items(page_number = 1)
      items = []

      login('yakovets.dima19@gmail.com', 'a.&jJ8iC3j8K&Mk')
      
      url = "#{Config.web_address}#{page_number != 1 ? "?p=#{page_number}" : ""}"

      doc = Nokogiri::HTML(Faraday.get(url).body)
      books = doc.css('.category-card.category-layout')

      books.each_with_index do |book, index|
        break unless Config.validator.call index
        book_url = "https://www.yakaboo.ua" + book.css('.category-card__name').attr('href').text.strip
        item = parse_item(book_url)

        next unless Config.condition.call item
        
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
      price =  book_doc.css('.ui-price-display__main').first.text.strip.match(Config.parse_item)[0].to_i

      Item.new({ 
        :title => title, 
        :author => author, 
        :categories => categories, 
        :price => price, 
        :image_url => image_url
      })
    end

    def login(username, password)
      mechanize = Mechanize.new
      mechanize.user_agent_alias = 'Windows Edge'
      mechanize.log = Logger.new("mechanize.log")
      mechanize.log.level = Logger::INFO
  
      page = mechanize.get('https://bibleproject.com/account/login/')
  
      form = page.forms[1]
      form['email'] = username
      form['password'] = password
  
      logged_in_page = form.submit
  
      return mechanize
    end
  end
end
