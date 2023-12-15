require 'pony'
require_relative 'config'

module Yakovets_Tsyhanash 
    class EmailSender 
      class << self 
        def send_email(path_to_zip_file, file_name) 
          begin
            Pony.mail({ 
            :to => 'yakovets.dima19@gmail.com', 
            :via => :smtp, 
            :via_options => { 
              :address              => 'smtp.gmail.com', 
              :port                 => '587', 
              :enable_starttls_auto => true,
              :user_name            => Yakovets_Tsyhanash::Config.user.email, 
              :password             => Yakovets_Tsyhanash::Config.user.password, 
              :authentication       => :plain,
              :domain               => "gmail.com"
            }, 
            :subject => 'Subject', 
            :body => 'Body', 
            :attachments => {"#{file_name}" => File.read(path_to_zip_file)} 
          })  
          rescue Net::ReadTimeout => e
            
          end
        end 
      end 
    end 
  end
  