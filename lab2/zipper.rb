require 'zip'

module Yakovets_Tsyhanash
  class Zipper
    class << self
      def create_archive(index)
        files = Dir.entries(Config.data_path) - %w[. ..] 

        zip_path = "#{Config.data_path}/#{index}_data.zip"
                
        File.delete(zip_path) if File.file?(zip_path) 
        
        Zip::File.open zip_path, create: true do |zip|
          files.each do |file|

            path = File.join(Config.data_path, file)
            
            zip.add(file, path) if File.file?(path) && file.start_with?("#{index}_")
          end
        end
      end
    end
  end
end
