require 'zip'

module Yakovets_Tsyhanash
  class Zipper
    class << self
      def create_archive
        entries = Dir.entries(Config::path) - %w[. ..] 

        Zip::File.open("#{Config::path}/data.zip", create: true) do |file|
          entries.each do |entry|
            entry_path = File.join(Config::path, entry)
            
            file.add(entry, entry_path) if File.file?(entry_path)
          end
        end
      end
    end
  end
end
