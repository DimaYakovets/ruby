require_relative 'config'

Program.config do |program|
    program.web_address = "https://www.imdb.com/chart/top/"
    program.path = "#{__dir__}/data"
    program.file_ext = [".txt", ".json", ".csv"]
    program.condition = ->(item) { true }

    program.user do |user|
        user.email = "amogus"
        user.password = "sus"
    end
end
