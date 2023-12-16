require_relative 'config'

module Yakovets_Tsyhanash
	Config.config do |program|
		program.web_address = "https://www.yakaboo.ua/ua/knigi/hudozhestvennaja-literatura.html"
		program.data_path = "#{__dir__}/data"
		program.file_ext = [".csv", ".json", ".yaml", ".txt"]
		program.condition = ->(item) { item.price < 1000 }
		program.parse_item = /\d+/
		program.validator = ->(index) { index < 10 }
		program.email_to_send = "yakovets.dima19@gmail.com"
		program.email_subject = "Лабораторна робота 2"
		program.email_body = "Добрий день. Це повідомлення надіслано з Yakaboo Parser Application. Дане повідомлення містить архів з даними до лаборатоної роботи 2."

		program.user do |user|
			user.email = "yakovets.dmytro@chnu.edu.ua"
			user.password = "cacm saug obkg knuq"
		end
	end
end
