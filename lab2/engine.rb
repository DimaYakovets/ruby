require_relative 'zipper'
require_relative 'parser'
require_relative 'init'
require_relative 'cart'
require_relative 'item'
require_relative 'main_application'
require 'thread'
require 'fileutils'

module Yakovets_Tsyhanash
  class Engine
    def run
      threads = (1..3).map do | index |
        Thread.new do
          Thread.current[:name] = "Task #{index}"

          puts "Task #{index} started"

          application = Yakovets_Tsyhanash::MainApplication.new
          
          application.run index

          zip_path = "#{Config.data_path}/#{index}_data.zip"

          Yakovets_Tsyhanash::EmailSender.send_email(zip_path, "#{index}_data.zip")

          puts "Zip '#{index}_data.zip' has been sent"

          puts "Task #{index} finished"
        end
      end

      Dir.foreach(Config.data_path) do |file|
        path = File.join(Config.data_path, file)

        File.delete(path) if file != '.' && file != '..'
      end

      begin
        threads.each do |thread|
          thread.join
        end
      rescue => exception
        puts exception.inspect
      end
    end
  end
end
