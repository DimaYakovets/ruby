require_relative 'config'

Config.config do |program|
	program.web_address = "https://www.yakaboo.ua/ua/knigi/hudozhestvennaja-literatura.html"
	program.path = "#{__dir__}/data"
	program.condition = ->(item) { item.price < 1000 }

	program.user do |user|
		user.email = "amogus"
		user.password = "sus"
	end
end
