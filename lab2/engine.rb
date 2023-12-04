require_relative 'zipper'
require_relative 'parser'
require_relative 'init'
require_relative 'cart'
require_relative 'item'
require_relative 'main_application'

module Yakovets_Tsyhanash
  class Engine
    def run
      app = MainApplication.new

      threads = []
      3.times do |i|
        threads << Thread.new { app.run i }
      end

      threads.each &:join
    end
  end
end
