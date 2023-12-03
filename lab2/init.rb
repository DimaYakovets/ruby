require_relative 'config'

module Yakovets_Tsyhanash
	Config.config do |program|
		program.web_address = "https://www.yakaboo.ua/ua/knigi/hudozhestvennaja-literatura.html"
		program.path = "#{__dir__}/data"
		program.file_ext = [".txt", ".json", ".csv", ".yaml"]
		program.condition = ->(item) { item.price < 1000 }

		program.user do |user|
			user.email = "amogus"
			user.password = "sus"
		end
	end
end
