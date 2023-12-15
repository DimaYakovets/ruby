require_relative 'config'

module Yakovets_Tsyhanash
	Config.config do |program|
		program.web_address = "https://www.yakaboo.ua/ua/knigi/hudozhestvennaja-literatura.html"
		program.data_path = "#{__dir__}/data"
		program.file_ext = [".txt", ".json", ".csv", ".yaml"]
		program.condition = ->(item) { item.price < 1000 }
		program.parse_item = /\d+/
		program.validator = ->(index) { index < 10 }

		program.user do |user|
			user.email = "yakovets.dmytro@chnu.edu.ua"
			user.password = "cacm saug obkg knuq"

			user
		end
	end
end
