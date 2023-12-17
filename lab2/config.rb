module Yakovets_Tsyhanash
  module Config
    class << self
      attr_accessor :web_address, :validator, :data_path, :parse_item, :file_ext, :condition, :user, :email_to_send, :email_subject, :email_body
      
      def config
        return to_s unless block_given?
        
        if @program
          puts "Application has been initialized already" 
          return
        end
        
        yield self

        @program ||= self
      end
      
      def user(&block)
        @user ||= User.config(&block)
      end 
    end
    
    class User 
      class << self
        attr_accessor :email, :password
        
        def config(&block)
          return to_s unless block_given?
        
          if @user
            puts "User has been initialized already" 
            return
          end
          
          yield self

          self
        end
      end
    end
  end
end
